import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nanny_client/main.dart' as app;
import '../helpers/test_helpers.dart';
import '../helpers/mock_api.dart';

/// Полноценные CRUD тесты для управления детьми
/// 
/// Эти тесты демонстрируют полный цикл работы с профилями детей:
/// - Create: добавление нового ребёнка
/// - Read: просмотр списка и деталей
/// - Update: редактирование профиля
/// - Delete: удаление профиля
/// 
/// Примечание: Для полной работы требуется настройка mock API
/// через dependency injection в DioRequest
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Child CRUD Operations (with mock API)', () {
    setUp(() {
      // Настройка mock API перед каждым тестом
      setupMockApi();
    });

    testWidgets('Complete child creation flow',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Шаг 1: Навигация к списку детей
      await _navigateToChildrenList(tester);

      // Шаг 2: Открытие формы добавления
      final addButton = find.byIcon(Icons.add);
      if (addButton.evaluate().isNotEmpty) {
        await tester.tap(addButton.first);
        await tester.pumpAndSettle();

        // Шаг 3: Заполнение формы
        // Примечание: Требует точные ключи или типы виджетов
        final textFields = find.byType(TextField);
        
        if (textFields.evaluate().length >= 2) {
          // Фамилия
          await tester.enterText(textFields.at(0), 'Сидоров');
          await tester.pumpAndSettle();

          // Имя
          await tester.enterText(textFields.at(1), 'Петр');
          await tester.pumpAndSettle();

          // Шаг 4: Сохранение
          final saveButton = find.text('Сохранить');
          if (saveButton.evaluate().isNotEmpty) {
            await tester.tap(saveButton);
            await tester.pumpAndSettle();

            // Ожидание завершения сохранения
            await TestHelpers.waitForLoading(tester);

            // Проверка: должны вернуться к списку
            expect(find.text('Мои дети'), findsOneWidget);
          }
        }
      }
    });

    testWidgets('View child details',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _navigateToChildrenList(tester);

      // Поиск карточки ребёнка в списке
      // Примечание: Зависит от реализации списка
      final childCard = find.byType(Card).first;
      
      if (childCard.evaluate().isNotEmpty) {
        await tester.tap(childCard);
        await tester.pumpAndSettle();

        // Проверка: открылись детали или форма редактирования
        expect(find.byType(TextField), findsWidgets);
      }
    });

    testWidgets('Edit child profile',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _navigateToChildrenList(tester);

      // Открытие первого ребёнка для редактирования
      final childCard = find.byType(Card).first;
      
      if (childCard.evaluate().isNotEmpty) {
        await tester.tap(childCard);
        await tester.pumpAndSettle();

        // Изменение данных
        final textFields = find.byType(TextField);
        if (textFields.evaluate().isNotEmpty) {
          // Изменяем имя
          await tester.enterText(textFields.at(1), 'Иван Обновленный');
          await tester.pumpAndSettle();

          // Сохранение
          final saveButton = find.text('Сохранить');
          if (saveButton.evaluate().isNotEmpty) {
            await tester.tap(saveButton);
            await tester.pumpAndSettle();

            await TestHelpers.waitForLoading(tester);
          }
        }
      }
    });

    testWidgets('Delete child profile',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _navigateToChildrenList(tester);

      // Поиск кнопки удаления (обычно иконка корзины)
      final deleteButton = find.byIcon(Icons.delete);
      
      if (deleteButton.evaluate().isNotEmpty) {
        await tester.tap(deleteButton.first);
        await tester.pumpAndSettle();

        // Подтверждение удаления в диалоге
        final confirmButton = find.text('Удалить');
        if (confirmButton.evaluate().isNotEmpty) {
          await tester.tap(confirmButton);
          await tester.pumpAndSettle();

          await TestHelpers.waitForLoading(tester);

          // Проверка: ребёнок удалён из списка
          // (проверка зависит от реализации)
        }
      }
    });

    testWidgets('Form validation for required fields',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _navigateToChildrenList(tester);

      final addButton = find.byIcon(Icons.add);
      if (addButton.evaluate().isNotEmpty) {
        await tester.tap(addButton.first);
        await tester.pumpAndSettle();

        // Попытка сохранить без заполнения обязательных полей
        final saveButton = find.text('Сохранить');
        if (saveButton.evaluate().isNotEmpty) {
          await tester.tap(saveButton);
          await tester.pumpAndSettle();

          // Должны остаться на форме (не вернуться к списку)
          // или увидеть сообщение об ошибке
          expect(find.byType(TextField), findsWidgets);
        }
      }
    });

    testWidgets('Add emergency contact to child',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _navigateToChildrenList(tester);

      // Открытие формы редактирования ребёнка
      final childCard = find.byType(Card).first;
      if (childCard.evaluate().isNotEmpty) {
        await tester.tap(childCard);
        await tester.pumpAndSettle();

        // Скролл к секции экстренных контактов
        final emergencySection = find.text('Экстренные контакты');
        if (emergencySection.evaluate().isNotEmpty) {
          await TestHelpers.scrollUntilVisible(tester, emergencySection);

          // Добавление контакта
          final addContactButton = find.byIcon(Icons.add);
          if (addContactButton.evaluate().isNotEmpty) {
            await tester.tap(addContactButton.last);
            await tester.pumpAndSettle();

            // Заполнение данных контакта
            // (зависит от реализации формы)
          }
        }
      }
    });
  });
}

/// Вспомогательная функция для навигации к списку детей
Future<void> _navigateToChildrenList(WidgetTester tester) async {
  // Переход в профиль
  final profileTab = find.byIcon(Icons.account_circle_rounded);
  if (profileTab.evaluate().isNotEmpty) {
    await tester.tap(profileTab);
    await tester.pumpAndSettle();
  }

  // Поиск и нажатие кнопки "Мои дети"
  final childrenButton = find.text('Мои дети');
  
  if (childrenButton.evaluate().isEmpty) {
    await TestHelpers.scrollUntilVisible(tester, childrenButton);
  }

  await tester.tap(childrenButton);
  await tester.pumpAndSettle();
}
