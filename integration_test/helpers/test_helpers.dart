import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Вспомогательные функции для integration тестов
class TestHelpers {
  /// Ожидание загрузки с таймаутом
  static Future<void> waitForLoading(
    WidgetTester tester, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final endTime = DateTime.now().add(timeout);
    
    while (DateTime.now().isBefore(endTime)) {
      await tester.pump(const Duration(milliseconds: 100));
      
      // Проверяем наличие индикаторов загрузки
      if (find.byType(CircularProgressIndicator).evaluate().isEmpty) {
        return;
      }
    }
    
    throw TimeoutException('Loading did not complete within $timeout');
  }

  /// Ввод текста в поле
  static Future<void> enterText(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }

  /// Скролл до элемента
  static Future<void> scrollUntilVisible(
    WidgetTester tester,
    Finder finder, {
    Finder? scrollable,
    double delta = 300,
  }) async {
    scrollable ??= find.byType(Scrollable).first;
    
    while (finder.evaluate().isEmpty) {
      await tester.drag(scrollable, Offset(0, -delta));
      await tester.pumpAndSettle();
    }
  }

  /// Проверка наличия снэкбара с сообщением
  static Finder findSnackBarWithText(String text) {
    return find.descendant(
      of: find.byType(SnackBar),
      matching: find.text(text),
    );
  }

  /// Ожидание появления виджета
  static Future<void> waitForWidget(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final endTime = DateTime.now().add(timeout);
    
    while (DateTime.now().isBefore(endTime)) {
      await tester.pump(const Duration(milliseconds: 100));
      
      if (finder.evaluate().isNotEmpty) {
        return;
      }
    }
    
    throw TimeoutException('Widget not found within $timeout');
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  
  @override
  String toString() => 'TimeoutException: $message';
}
