import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/utils/event_comparator.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';

void main() {
  EventComparator eventComparator;

  setUp(() {
    eventComparator = EventComparator();
  });

  final tEventearly = Event(
    name: 'event early',
    createDateTime: DateTime(1992),
    startDateTime: DateTime(1992, 5, 26, 10, 30),
  );
  final tEventlate = Event(
    name: 'event late',
    createDateTime: DateTime(1992),
    startDateTime: DateTime(1992, 5, 26, 13, 30),
  );
  final tEventAllDay = Event(
    name: 'event all-day',
    createDateTime: DateTime(1992),
    startDateTime: DateTime(1992, 5, 26, 12, 00),
    allDay: true,
  );

  test(
    '''shoud return 0 when the startDateTime of the first event argument
     is before the startDateTime of the second event argument''',
    () async {
      // act
      final result = eventComparator(tEventearly, tEventlate);

      // assert
      expect(result, equals(0));
    },
  );

  test(
    '''shoud return 1 when the startDateTime of the first event argument
     is after the startDateTime of the second event argument''',
    () async {
      // act
      final result = eventComparator(tEventlate, tEventearly);

      // assert
      expect(result, equals(1));
    },
  );

  test(
    '''shoud return 1 when the startDateTime of the first event argument
     is after the startDateTime of the second event argument''',
    () async {
      // act
      final result = eventComparator(tEventearly, tEventearly);

      // assert
      expect(result, equals(1));
    },
  );

  test(
    'shoud return 0 when the allDay of the first event argument is true',
    () async {
      // act
      final result = eventComparator(tEventAllDay, tEventearly);

      // assert
      expect(result, equals(0));
    },
  );

  test(
    '''shoud return 1 when the allDay of the first event argument is false
     and the allDay of the second event argument is true''',
    () async {
      // act
      final result = eventComparator(tEventearly, tEventAllDay);

      // assert
      expect(result, equals(0));
    },
  );
}
