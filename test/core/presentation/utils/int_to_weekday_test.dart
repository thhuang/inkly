import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/presentation/utils/int_to_weekday.dart';

void main() {
  IntToWeekday intToWeekday;

  setUp(() {
    intToWeekday = IntToWeekday();
  });

  test(
    'should return the name of the day',
    () async {
      // act
      final result = [
        intToWeekday(1),
        intToWeekday(2),
        intToWeekday(3),
        intToWeekday(4),
        intToWeekday(5),
        intToWeekday(6),
        intToWeekday(7),
      ];

      // assert
      final expectedResult = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];
      expect(result, equals(expectedResult));
    },
  );

  test(
    'should return null when the input number is not an integer in [1, 7]',
    () async {
      // act
      final result = [
        intToWeekday(0),
        intToWeekday(8),
      ];

      // assert
      final expectedResult = [null, null];
      expect(result, equals(expectedResult));
    },
  );

  group('abbriviation', () {
    test(
      'should return the abbriviation of the name of the day',
      () async {
        // act
        final result = [
          intToWeekday.abbriviation(1),
          intToWeekday.abbriviation(2),
          intToWeekday.abbriviation(3),
          intToWeekday.abbriviation(4),
          intToWeekday.abbriviation(5),
          intToWeekday.abbriviation(6),
          intToWeekday.abbriviation(7),
        ];

        // assert
        final expectedResult = [
          'Mon',
          'Tue',
          'Wed',
          'Thu',
          'Fri',
          'Sat',
          'Sun',
        ];
        expect(result, equals(expectedResult));
      },
    );

    test(
      'should return null when the input number is not an integer in [1, 7]',
      () async {
        // act
        final result = [
          intToWeekday.abbriviation(0),
          intToWeekday.abbriviation(8),
        ];

        // assert
        final expectedResult = [null, null];
        expect(result, equals(expectedResult));
      },
    );
  });
}
