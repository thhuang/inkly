import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/presentation/utils/int_to_month.dart';

void main() {
  IntToMonth intToMonth;

  setUp(() {
    intToMonth = IntToMonth();
  });

  test(
    'should return the name of the month',
    () async {
      // act
      final result = [
        intToMonth(1),
        intToMonth(2),
        intToMonth(3),
        intToMonth(4),
        intToMonth(5),
        intToMonth(6),
        intToMonth(7),
        intToMonth(8),
        intToMonth(9),
        intToMonth(10),
        intToMonth(11),
        intToMonth(12),
      ];

      // assert
      final expectedResult = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      expect(result, equals(expectedResult));
    },
  );

  test(
    'should return null when the input number is not an integer in [1, 12]',
    () async {
      // act
      final result = [
        intToMonth(0),
        intToMonth(13),
      ];

      // assert
      final expectedResult = [null, null];
      expect(result, equals(expectedResult));
    },
  );

  group('abbriviation', () {
    test(
      'should return the abbriviation of the name of the month',
      () async {
        // act
        final result = [
          intToMonth.abbriviation(1),
          intToMonth.abbriviation(2),
          intToMonth.abbriviation(3),
          intToMonth.abbriviation(4),
          intToMonth.abbriviation(5),
          intToMonth.abbriviation(6),
          intToMonth.abbriviation(7),
          intToMonth.abbriviation(8),
          intToMonth.abbriviation(9),
          intToMonth.abbriviation(10),
          intToMonth.abbriviation(11),
          intToMonth.abbriviation(12),
        ];

        // assert
        final expectedResult = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        expect(result, equals(expectedResult));
      },
    );

    test(
      'should return null when the input number is not an integer in [1, 12]',
      () async {
        // act
        final result = [
          intToMonth.abbriviation(0),
          intToMonth.abbriviation(13),
        ];

        // assert
        final expectedResult = [null, null];
        expect(result, equals(expectedResult));
      },
    );
  });
}
