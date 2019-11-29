import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/utils/event_list_to_event_map.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';

void main() {
  EventListToEventMap eventListToEventMap;

  setUp(() {
    eventListToEventMap = EventListToEventMap();
  });

  test(
    'should convert the event list to event map',
    () async {
      // arrange
      final tEventList = [
        Event(
          name: 'test 0',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-10T10:00:00.000'),
          endDateTime: DateTime.parse('2019-11-10T12:00:00.000'),
        ),
        Event(
          name: 'test 1',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-10T11:00:00.000'),
          endDateTime: DateTime.parse('2019-11-10T13:00:00.000'),
        ),
        Event(
          name: 'test 2',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-11T12:00:00.000'),
          endDateTime: DateTime.parse('2019-11-11T14:00:00.000'),
        ),
        Event(
          name: 'test 3',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-11T19:00:00.000'),
          endDateTime: DateTime.parse('2019-11-11T21:00:00.000'),
        ),
        Event(
          name: 'test 4',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-28T09:00:00.000'),
          endDateTime: DateTime.parse('2019-11-28T23:00:00.000'),
        ),
        Event(
          name: 'test 5',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-11T06:00:00.000'),
          endDateTime: DateTime.parse('2019-11-11T16:00:00.000'),
        ),
        Event(
          name: 'test 6',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-18T20:00:00.000'),
          endDateTime: DateTime.parse('2019-11-19T03:00:00.000'),
        ),
        Event(
          name: 'test 7',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-19T00:00:00.000'),
          endDateTime: DateTime.parse('2019-11-19T24:00:00.000'),
        ),
        Event(
          name: 'test 8',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-19T00:00:00.000'),
          endDateTime: DateTime.parse('2019-11-21T00:00:01.000'),
        ),
        Event(
          name: 'test 9',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-18T23:59:59.000'),
          endDateTime: DateTime.parse('2019-11-19T00:00:00.000'),
        ),
      ];

      // act
      final result = eventListToEventMap(tEventList);

      // assert
      final expectedEventMap = {
        DateTime.parse('2019-11-10T00:00:00.000'): [
          tEventList[0],
          tEventList[1],
        ],
        DateTime.parse('2019-11-11T00:00:00.000'): [
          tEventList[2],
          tEventList[3],
          tEventList[5],
        ],
        DateTime.parse('2019-11-28T00:00:00.000'): [
          tEventList[4],
        ],
        DateTime.parse('2019-11-18T00:00:00.000'): [
          tEventList[6],
          tEventList[9],
        ],
        DateTime.parse('2019-11-19T00:00:00.000'): [
          tEventList[6],
          tEventList[7],
          tEventList[8],
        ],
        DateTime.parse('2019-11-20T00:00:00.000'): [
          tEventList[8],
        ],
        DateTime.parse('2019-11-21T00:00:00.000'): [
          tEventList[8],
        ],
      };
      print(result[DateTime.parse('2019-11-19T00:00:00.000')][0].startDateTime);
      print(result[DateTime.parse('2019-11-19T00:00:00.000')][0].endDateTime);
      print(result[DateTime.parse('2019-11-19T00:00:00.000')][1].startDateTime);
      print(result[DateTime.parse('2019-11-19T00:00:00.000')][1].endDateTime);
      expect(result, equals(expectedEventMap));
    },
  );

  test(
    'should not add the same event twice to event map',
    () async {
      // arrange
      final tEventList = [
        Event(
          name: 'test 0',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-10T10:00:00.000'),
          endDateTime: DateTime.parse('2019-11-10T12:00:00.000'),
        ),
        Event(
          name: 'test 1',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-10T11:00:00.000'),
          endDateTime: DateTime.parse('2019-11-10T13:00:00.000'),
        ),
        Event(
          name: 'test 2',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-11T12:00:00.000'),
          endDateTime: DateTime.parse('2019-11-11T14:00:00.000'),
        ),
        Event(
          name: 'test 3',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-11T19:00:00.000'),
          endDateTime: DateTime.parse('2019-11-11T21:00:00.000'),
        ),
        Event(
          name: 'test 4',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-28T09:00:00.000'),
          endDateTime: DateTime.parse('2019-11-28T23:00:00.000'),
        ),
        Event(
          name: 'test 5',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-11T06:00:00.000'),
          endDateTime: DateTime.parse('2019-11-11T16:00:00.000'),
        ),
        Event(
          name: 'test 6',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-18T20:00:00.000'),
          endDateTime: DateTime.parse('2019-11-19T03:00:00.000'),
        ),
        Event(
          name: 'test 7',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-19T00:00:00.000'),
          endDateTime: DateTime.parse('2019-11-19T24:00:00.000'),
        ),
        Event(
          name: 'test 8',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-19T00:00:00.000'),
          endDateTime: DateTime.parse('2019-11-19T00:00:01.000'),
        ),
      ];
      final tNewEvent = Event(
        name: 'test 9',
        createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
        startDateTime: DateTime.parse('2019-11-18T23:59:59.000'),
        endDateTime: DateTime.parse('2019-11-19T00:00:00.000'),
      );

      // act
      final result1 = eventListToEventMap(tEventList);
      tEventList.add(tNewEvent);
      final result2 = eventListToEventMap(tEventList);

      // assert
      final expectedEventMap1 = {
        DateTime.parse('2019-11-10T00:00:00.000'): [
          tEventList[0],
          tEventList[1],
        ],
        DateTime.parse('2019-11-11T00:00:00.000'): [
          tEventList[2],
          tEventList[3],
          tEventList[5],
        ],
        DateTime.parse('2019-11-28T00:00:00.000'): [
          tEventList[4],
        ],
        DateTime.parse('2019-11-18T00:00:00.000'): [
          tEventList[6],
        ],
        DateTime.parse('2019-11-19T00:00:00.000'): [
          tEventList[6],
          tEventList[7],
          tEventList[8],
        ],
      };
      final expectedEventMap2 = {
        DateTime.parse('2019-11-10T00:00:00.000'): [
          tEventList[0],
          tEventList[1],
        ],
        DateTime.parse('2019-11-11T00:00:00.000'): [
          tEventList[2],
          tEventList[3],
          tEventList[5],
        ],
        DateTime.parse('2019-11-28T00:00:00.000'): [
          tEventList[4],
        ],
        DateTime.parse('2019-11-18T00:00:00.000'): [
          tEventList[6],
          tEventList[9],
        ],
        DateTime.parse('2019-11-19T00:00:00.000'): [
          tEventList[6],
          tEventList[7],
          tEventList[8],
        ],
      };
      expect(result1, equals(expectedEventMap1));
      expect(result2, equals(expectedEventMap2));
    },
  );

  test(
    'should not add the event to the map when the event does not have a starting time',
    () async {
      // arrange
      final tEventList = [
        Event(
          name: 'test 0',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
        ),
        Event(
          name: 'test 1',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
        ),
        Event(
          name: 'test 2',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
        ),
        Event(
          name: 'test 3',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-11T19:00:00.000'),
          endDateTime: DateTime.parse('2019-11-11T21:00:00.000'),
        ),
        Event(
          name: 'test 4',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-28T09:00:00.000'),
          endDateTime: DateTime.parse('2019-11-28T23:00:00.000'),
        ),
        Event(
          name: 'test 5',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-11T06:00:00.000'),
          endDateTime: DateTime.parse('2019-11-11T16:00:00.000'),
        ),
        Event(
          name: 'test 6',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-18T20:00:00.000'),
          endDateTime: DateTime.parse('2019-11-19T03:00:00.000'),
        ),
        Event(
          name: 'test 7',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-19T00:00:00.000'),
          endDateTime: DateTime.parse('2019-11-19T24:00:00.000'),
        ),
        Event(
          name: 'test 8',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-19T00:00:00.000'),
          endDateTime: DateTime.parse('2019-11-19T00:00:01.000'),
        ),
        Event(
          name: 'test 9',
          createDateTime: DateTime.parse('2019-11-18T12:00:00.000'),
          startDateTime: DateTime.parse('2019-11-18T23:59:59.000'),
          endDateTime: DateTime.parse('2019-11-19T00:00:00.000'),
        ),
      ];

      // act
      final result = eventListToEventMap(tEventList);

      // assert
      final expectedEventMap = {
        DateTime.parse('2019-11-11T00:00:00.000'): [
          tEventList[3],
          tEventList[5],
        ],
        DateTime.parse('2019-11-28T00:00:00.000'): [
          tEventList[4],
        ],
        DateTime.parse('2019-11-18T00:00:00.000'): [
          tEventList[6],
          tEventList[9],
        ],
        DateTime.parse('2019-11-19T00:00:00.000'): [
          tEventList[6],
          tEventList[7],
          tEventList[8],
        ],
      };
      expect(result, equals(expectedEventMap));
    },
  );
}
