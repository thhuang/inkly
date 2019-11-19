import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/features/calendar/data/models/event_model.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tEventModelMin = EventModel(
    id: 0,
    name: 'test',
    createDateTime: DateTime.parse('2019-11-18T12:00:00.000Z'),
  );
  final tEventModel = EventModel(
    id: 0,
    name: 'test',
    createDateTime: DateTime.parse('2019-11-18T12:00:00.000Z'),
    creator: 'user1',
    participants: ['user1', 'user2', 'user3'],
    startDateTime: DateTime.parse('2019-11-19T10:00:00.000Z'),
    endDateTime: DateTime.parse('2019-11-19T14:00:00.000Z'),
    tag: 'fixture',
  );
  final tEventModelWithoutId = EventModel(
    id: null,
    name: 'test',
    createDateTime: DateTime.parse('2019-11-18T12:00:00.000Z'),
    creator: 'user1',
    participants: ['user1', 'user2', 'user3'],
    startDateTime: DateTime.parse('2019-11-19T10:00:00.000Z'),
    endDateTime: DateTime.parse('2019-11-19T14:00:00.000Z'),
    tag: 'fixture',
  );

  test(
    'should be a subclass of Event entity',
    () async {
      // assert
      expect(tEventModel, isA<Event>());
    },
  );

  group('fromMap', () {
    test(
      'should return a valid model from a map',
      () async {
        // arrange
        final eventMap = jsonDecode(fixture('event.json'));

        // act
        final result = EventModel.fromMap(eventMap);

        // assert
        expect(result, equals(tEventModel));
      },
    );

    test(
      'should return a valid model from a map with minimum required fields',
      () async {
        // arrange
        final eventMap = jsonDecode(fixture('event_min.json'));

        // act
        final result = EventModel.fromMap(eventMap);

        // assert
        expect(result, equals(tEventModelMin));
      },
    );
  });

  group('toMap', () {
    test(
      'should return a map containing the proper data',
      () async {
        // act
        final result = tEventModel.toMap();

        // assert
        final expectedEventMap = {
          'id': 0,
          'name': 'test',
          'createDateTime': '2019-11-18T12:00:00.000Z',
          'creator': 'user1',
          'participants': '["user1","user2","user3"]',
          'startDateTime': '2019-11-19T10:00:00.000Z',
          'endDateTime': '2019-11-19T14:00:00.000Z',
          'tag': 'fixture',
        };
        expect(result, equals(expectedEventMap));
      },
    );

    test(
      'should return a map containing the proper data when EventModel have only minimum required fields',
      () async {
        // act
        final result = tEventModelMin.toMap();

        // assert
        final expectedEventMap = {
          'id': 0,
          'name': 'test',
          'createDateTime': '2019-11-18T12:00:00.000Z',
          'creator': null,
          'participants': null,
          'startDateTime': null,
          'endDateTime': null,
          'tag': null,
        };

        // assert
        expect(result, equals(expectedEventMap));
      },
    );

    test(
      'should return a map containing the proper data without id when id in EventModel is null',
      () async {
        // act
        final result = tEventModelWithoutId.toMap();

        // assert
        final expectedEventMap = {
          'name': 'test',
          'createDateTime': '2019-11-18T12:00:00.000Z',
          'creator': 'user1',
          'participants': '["user1","user2","user3"]',
          'startDateTime': '2019-11-19T10:00:00.000Z',
          'endDateTime': '2019-11-19T14:00:00.000Z',
          'tag': 'fixture',
        };

        // assert
        expect(result, equals(expectedEventMap));
      },
    );
  });
}
