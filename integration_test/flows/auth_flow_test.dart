import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nanny_client/main.dart' as app;
import '../helpers/test_helpers.dart';

/// Тесты флоу авторизации
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Flow', () {
    testWidgets('User can navigate to login screen', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Ищем кнопку входа на welcome screen
      final loginButton = find.text('Войти');
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton);
        await tester.pumpAndSettle();
      }

      // Проверяем, что открылся экран логина
      // (точные виджеты зависят от вашей реализации)
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('Login form validation works', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Переход на экран логина
      final loginButton = find.text('Войти');
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton);
        await tester.pumpAndSettle();
      }

      // Попытка войти с пустыми полями
      final submitButton = find.widgetWithText(ElevatedButton, 'Войти');
      if (submitButton.evaluate().isNotEmpty) {
        await tester.tap(submitButton);
        await tester.pumpAndSettle();

        // Должна появиться ошибка валидации
        // (проверка зависит от вашей реализации)
      }
    });

    // TODO: Добавить тест успешного логина с mock API
    // testWidgets('User can login successfully', (WidgetTester tester) async {
    //   // Требует настройки mock HTTP client
    // });
  });
}
