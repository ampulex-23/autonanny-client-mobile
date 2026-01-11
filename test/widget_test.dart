import 'package:flutter_test/flutter_test.dart';
import 'package:nanny_core/models/from_api/child.dart';

/// Базовые unit тесты для AutoNanny Client
void main() {
  group('Child Model', () {
    test('should create child from JSON', () {
      final json = {
        'id': 1,
        'name': 'Иван',
        'surname': 'Иванов',
        'id_user': 10,
        'isActive': true,
      };

      final child = Child.fromJson(json);

      expect(child.id, 1);
      expect(child.name, 'Иван');
      expect(child.surname, 'Иванов');
      expect(child.fullName, 'Иванов Иван');
      expect(child.idUser, 10);
    });

    test('should handle patronymic in fullName', () {
      final child = Child(
        surname: 'Иванов',
        name: 'Иван',
        patronymic: 'Петрович',
        idUser: 10,
      );

      expect(child.fullName, 'Иванов Иван Петрович');
    });
  });

  // TODO: Добавьте больше unit тестов для моделей, сервисов и утилит
  // Примеры:
  // - test('GraphType.week should have correct duration', () { ... });
  // - test('TextMasks.phoneMask should format phone', () { ... });
}
