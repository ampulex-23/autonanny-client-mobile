import 'package:flutter_test/flutter_test.dart';
import 'package:nanny_core/nanny_core.dart';

void main() {
  group('GraphType', () {
    test('week should have correct properties', () {
      expect(GraphType.week.name, 'Недельный');
      expect(GraphType.week.duration, 7);
    });

    test('month should have correct properties', () {
      expect(GraphType.month.name, 'Месячный');
      expect(GraphType.month.duration, 30);
    });

    test('halfYear should have correct properties', () {
      expect(GraphType.halfYear.name, 'Полугодовой');
      expect(GraphType.halfYear.duration, 182);
    });

    test('year should have correct properties', () {
      expect(GraphType.year.name, 'Годовой');
      expect(GraphType.year.duration, 365);
    });

    test('should find GraphType by duration', () {
      final weekType = GraphType.values.firstWhere(
        (e) => e.duration == 7,
      );
      expect(weekType, GraphType.week);

      final monthType = GraphType.values.firstWhere(
        (e) => e.duration == 30,
      );
      expect(monthType, GraphType.month);
    });

    test('all types should have unique durations', () {
      final durations = GraphType.values.map((e) => e.duration).toList();
      final uniqueDurations = durations.toSet();
      
      expect(durations.length, uniqueDurations.length);
    });
  });
}
