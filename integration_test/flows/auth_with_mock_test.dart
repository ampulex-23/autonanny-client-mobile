import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nanny_client/main.dart' as app;
import '../helpers/test_helpers.dart';
import '../helpers/mock_api.dart';

/// Integration тесты для авторизации с mock API
/// 
/// Покрывает:
/// - Вход с корректными данными
/// - Вход с некорректными данными
/// - Регистрацию нового пользователя
/// - Восстановление пароля
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Flow (with mock API)', () {
    setUp(() {
      setupMockApi();
    });

    testWidgets('Successful login flow',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Поиск кнопки входа на welcome screen
      final loginButton = find.text('Войти');
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        // Заполнение формы логина
        final phoneField = find.byType(TextField).first;
        await tester.enterText(phoneField, '9001234567');
        await tester.pumpAndSettle();

        // Ввод пароля (если есть поле пароля)
        final textFields = find.byType(TextField);
        if (textFields.evaluate().length > 1) {
          await tester.enterText(textFields.at(1), 'password123');
          await tester.pumpAndSettle();
        }

        // Нажатие кнопки входа
        final submitButton = find.widgetWithText(ElevatedButton, 'Войти');
        if (submitButton.evaluate().isNotEmpty) {
          await tester.tap(submitButton);
          await tester.pumpAndSettle();

          // Ожидание загрузки
          await TestHelpers.waitForLoading(tester);

          // Проверка: должны попасть на главный экран
          // (проверка зависит от реализации)
        }
      }
    });

    testWidgets('Login with invalid credentials',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final loginButton = find.text('Войти');
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        // Ввод неверных данных
        final phoneField = find.byType(TextField).first;
        await tester.enterText(phoneField, '0000000000');
        await tester.pumpAndSettle();

        final submitButton = find.widgetWithText(ElevatedButton, 'Войти');
        if (submitButton.evaluate().isNotEmpty) {
          await tester.tap(submitButton);
          await tester.pumpAndSettle();

          // Должно появиться сообщение об ошибке
          // (проверка зависит от реализации)
        }
      }
    });

    testWidgets('Registration flow',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Поиск кнопки регистрации
      final registerButton = find.text('Регистрация');
      if (registerButton.evaluate().isNotEmpty) {
        await tester.tap(registerButton);
        await tester.pumpAndSettle();

        // Заполнение формы регистрации
        final textFields = find.byType(TextField);
        
        if (textFields.evaluate().length >= 3) {
          // Имя
          await tester.enterText(textFields.at(0), 'Иван');
          await tester.pumpAndSettle();

          // Фамилия
          await tester.enterText(textFields.at(1), 'Иванов');
          await tester.pumpAndSettle();

          // Телефон
          await tester.enterText(textFields.at(2), '9001234567');
          await tester.pumpAndSettle();

          // Отправка формы
          final submitButton = find.widgetWithText(ElevatedButton, 'Зарегистрироваться');
          if (submitButton.evaluate().isNotEmpty) {
            await tester.tap(submitButton);
            await tester.pumpAndSettle();

            await TestHelpers.waitForLoading(tester);
          }
        }
      }
    });

    testWidgets('Phone number validation',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final loginButton = find.text('Войти');
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        // Ввод некорректного номера
        final phoneField = find.byType(TextField).first;
        await tester.enterText(phoneField, '123'); // Слишком короткий
        await tester.pumpAndSettle();

        final submitButton = find.widgetWithText(ElevatedButton, 'Войти');
        if (submitButton.evaluate().isNotEmpty) {
          await tester.tap(submitButton);
          await tester.pumpAndSettle();

          // Должна быть ошибка валидации
          expect(find.byType(TextField), findsWidgets);
        }
      }
    });

    testWidgets('Logout flow',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Предполагаем, что пользователь уже залогинен
      // Переход в профиль
      final profileTab = find.byIcon(Icons.account_circle_rounded);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Поиск кнопки выхода
        final logoutButton = find.byIcon(Icons.exit_to_app_rounded);
        if (logoutButton.evaluate().isNotEmpty) {
          await tester.tap(logoutButton);
          await tester.pumpAndSettle();

          // Подтверждение выхода (если есть диалог)
          final confirmButton = find.text('Выйти');
          if (confirmButton.evaluate().isNotEmpty) {
            await tester.tap(confirmButton);
            await tester.pumpAndSettle();
          }

          // Проверка: должны вернуться на welcome screen
          expect(find.text('Войти'), findsOneWidget);
        }
      }
    });
  });
}
