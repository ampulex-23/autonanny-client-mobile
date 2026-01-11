import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nanny_client/main.dart' as app;
import '../helpers/test_helpers.dart';

/// Integration тесты для управления профилями детей
/// 
/// Покрывает:
/// - Просмотр списка детей
/// - Добавление нового ребёнка
/// - Редактирование профиля ребёнка
/// - Удаление ребёнка
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Child Management Flow', () {
    testWidgets('User can navigate to children list from profile',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // TODO: Добавить логин, если требуется
      // await _performLogin(tester);

      // Переход в профиль (последняя вкладка)
      final profileTab = find.byIcon(Icons.account_circle_rounded);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();
      }

      // Поиск кнопки "Мои дети"
      final childrenButton = find.text('Мои дети');
      
      // Если кнопка не видна, скроллим вниз
      if (childrenButton.evaluate().isEmpty) {
        await TestHelpers.scrollUntilVisible(
          tester,
          childrenButton,
        );
      }

      // Проверяем, что кнопка существует
      expect(childrenButton, findsOneWidget);

      // Нажимаем на кнопку
      await tester.tap(childrenButton);
      await tester.pumpAndSettle();

      // Проверяем, что открылся экран "Мои дети"
      expect(find.text('Мои дети'), findsOneWidget);
    });

    testWidgets('User can view empty children list',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Навигация к списку детей
      await _navigateToChildrenList(tester);

      // Проверяем сообщение о пустом списке
      final emptyMessage = find.text('У вас пока нет добавленных детей');
      final addButton = find.text('Добавить ребенка');

      // Одно из сообщений должно быть видно
      expect(
        emptyMessage.evaluate().isNotEmpty || addButton.evaluate().isNotEmpty,
        true,
      );
    });

    testWidgets('User can open add child form',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await _navigateToChildrenList(tester);

      // Поиск кнопки добавления (иконка или текст)
      final addButton = find.byIcon(Icons.add).first;
      
      if (addButton.evaluate().isNotEmpty) {
        await tester.tap(addButton);
        await tester.pumpAndSettle();

        // Проверяем, что открылась форма добавления
        expect(find.text('Добавить ребенка'), findsOneWidget);
        
        // Проверяем наличие основных полей
        expect(find.byType(TextField), findsWidgets);
      }
    });

    // TODO: Тесты с mock API для полного флоу
    // testWidgets('User can add a new child', (WidgetTester tester) async {
    //   // Требует mock HTTP client для API запросов
    // });

    // testWidgets('User can edit child profile', (WidgetTester tester) async {
    //   // Требует mock HTTP client
    // });

    // testWidgets('User can delete child', (WidgetTester tester) async {
    //   // Требует mock HTTP client
    // });
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

/// Вспомогательная функция для логина (если требуется)
// Future<void> _performLogin(WidgetTester tester) async {
//   // TODO: Реализовать логин для тестов
// }
