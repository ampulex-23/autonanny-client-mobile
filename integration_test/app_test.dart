import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nanny_client/main.dart' as app;

/// Базовый integration тест для проверки запуска приложения
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Launch Tests', () {
    testWidgets('App should launch successfully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Проверяем, что приложение запустилось
      expect(find.byType(app.MyApp), findsOneWidget);
    });
  });
}
