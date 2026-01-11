import 'package:flutter_test/flutter_test.dart';
import 'package:nanny_core/models/from_api/child.dart';

void main() {
  group('Child Model', () {
    group('fromJson', () {
      test('should parse complete JSON correctly', () {
        final json = {
          'id': 1,
          'name': 'Иван',
          'surname': 'Иванов',
          'patronymic': 'Петрович',
          'id_user': 10,
          'age': 8,
          'birthday': '2015-05-15',
          'gender': 'M',
          'photo_path': '/photos/child1.jpg',
          'school_class': '2А класс',
          'character_notes': 'Активный, любит спорт',
          'child_phone': '+79001234567',
          'isActive': true,
          'datetime_create': '2024-01-01T10:00:00',
        };

        final child = Child.fromJson(json);

        expect(child.id, 1);
        expect(child.name, 'Иван');
        expect(child.surname, 'Иванов');
        expect(child.patronymic, 'Петрович');
        expect(child.idUser, 10);
        expect(child.age, 8);
        expect(child.birthday, DateTime.parse('2015-05-15'));
        expect(child.gender, 'M');
        expect(child.photoPath, '/photos/child1.jpg');
        expect(child.schoolClass, '2А класс');
        expect(child.characterNotes, 'Активный, любит спорт');
        expect(child.childPhone, '+79001234567');
        expect(child.isActive, true);
      });

      test('should handle minimal JSON', () {
        final json = {
          'name': 'Мария',
          'surname': 'Петрова',
          'id_user': 5,
        };

        final child = Child.fromJson(json);

        expect(child.id, null);
        expect(child.name, 'Мария');
        expect(child.surname, 'Петрова');
        expect(child.patronymic, null);
        expect(child.idUser, 5);
        expect(child.age, null);
        expect(child.birthday, null);
      });

      test('should handle empty strings as empty', () {
        final json = {
          'name': '',
          'surname': '',
          'id_user': 1,
        };

        final child = Child.fromJson(json);

        expect(child.name, '');
        expect(child.surname, '');
      });
    });

    group('toJson', () {
      test('should serialize to JSON correctly', () {
        final child = Child(
          id: 1,
          name: 'Иван',
          surname: 'Иванов',
          patronymic: 'Петрович',
          idUser: 10,
          age: 8,
          birthday: DateTime.parse('2015-05-15'),
          gender: 'M',
          photoPath: '/photos/child1.jpg',
          schoolClass: '2А класс',
          characterNotes: 'Активный',
          childPhone: '+79001234567',
          isActive: true,
        );

        final json = child.toJson();

        expect(json['id'], 1);
        expect(json['name'], 'Иван');
        expect(json['surname'], 'Иванов');
        expect(json['patronymic'], 'Петрович');
        expect(json['id_user'], 10);
        expect(json['age'], 8);
        expect(json['birthday'], '2015-05-15');
        expect(json['gender'], 'M');
        expect(json['photo_path'], '/photos/child1.jpg');
        expect(json['school_class'], '2А класс');
        expect(json['character_notes'], 'Активный');
        expect(json['child_phone'], '+79001234567');
        expect(json['isActive'], true);
      });

      test('should omit null values', () {
        final child = Child(
          name: 'Мария',
          surname: 'Петрова',
          idUser: 5,
        );

        final json = child.toJson();

        expect(json.containsKey('id'), false);
        expect(json.containsKey('patronymic'), false);
        expect(json.containsKey('age'), false);
        expect(json.containsKey('birthday'), false);
      });
    });

    group('fullName', () {
      test('should return full name with patronymic', () {
        final child = Child(
          surname: 'Иванов',
          name: 'Иван',
          patronymic: 'Петрович',
          idUser: 1,
        );

        expect(child.fullName, 'Иванов Иван Петрович');
      });

      test('should return name without patronymic', () {
        final child = Child(
          surname: 'Петрова',
          name: 'Мария',
          idUser: 1,
        );

        expect(child.fullName, 'Петрова Мария');
      });

      test('should handle empty patronymic', () {
        final child = Child(
          surname: 'Сидоров',
          name: 'Петр',
          patronymic: '',
          idUser: 1,
        );

        expect(child.fullName, 'Сидоров Петр');
      });
    });

    group('ageDisplay', () {
      test('should display age from age field', () {
        final child = Child(
          surname: 'Иванов',
          name: 'Иван',
          idUser: 1,
          age: 8,
        );

        expect(child.ageDisplay, '8 лет');
      });

      test('should calculate age from birthday', () {
        final now = DateTime.now();
        final birthday = DateTime(now.year - 10, now.month, now.day);
        
        final child = Child(
          surname: 'Петрова',
          name: 'Мария',
          idUser: 1,
          birthday: birthday,
        );

        expect(child.ageDisplay, '10 лет');
      });

      test('should use correct word forms for age', () {
        expect(
          Child(surname: 'A', name: 'B', idUser: 1, age: 1).ageDisplay,
          '1 год',
        );
        expect(
          Child(surname: 'A', name: 'B', idUser: 1, age: 2).ageDisplay,
          '2 года',
        );
        expect(
          Child(surname: 'A', name: 'B', idUser: 1, age: 5).ageDisplay,
          '5 лет',
        );
        expect(
          Child(surname: 'A', name: 'B', idUser: 1, age: 11).ageDisplay,
          '11 лет',
        );
        expect(
          Child(surname: 'A', name: 'B', idUser: 1, age: 21).ageDisplay,
          '21 год',
        );
        expect(
          Child(surname: 'A', name: 'B', idUser: 1, age: 22).ageDisplay,
          '22 года',
        );
      });

      test('should return default message when no age data', () {
        final child = Child(
          surname: 'Иванов',
          name: 'Иван',
          idUser: 1,
        );

        expect(child.ageDisplay, 'Возраст не указан');
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        final original = Child(
          id: 1,
          surname: 'Иванов',
          name: 'Иван',
          idUser: 10,
          age: 8,
        );

        final copy = original.copyWith(
          name: 'Петр',
          age: 9,
        );

        expect(copy.id, 1);
        expect(copy.surname, 'Иванов');
        expect(copy.name, 'Петр');
        expect(copy.idUser, 10);
        expect(copy.age, 9);
      });

      test('should keep original values when not specified', () {
        final original = Child(
          id: 1,
          surname: 'Иванов',
          name: 'Иван',
          patronymic: 'Петрович',
          idUser: 10,
        );

        final copy = original.copyWith(name: 'Петр');

        expect(copy.patronymic, 'Петрович');
        expect(copy.idUser, 10);
      });
    });
  });
}
