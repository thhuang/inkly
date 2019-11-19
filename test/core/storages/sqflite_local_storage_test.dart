import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/storages/sqflite_local_storage.dart';
import 'package:inkly/features/calendar/data/models/event_model.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import '../../fixtures/fixture_reader.dart';

class MockDataBase extends Mock implements Database {}

class MockEventModel extends Mock implements EventModel {}

void main() {
  SqfliteLocalStorage sqfliteLocalStorage;
  MockDataBase mockDataBase;
  MockEventModel tEventModel;
  int tEventId;

  setUp(() {
    mockDataBase = MockDataBase();
    sqfliteLocalStorage = SqfliteLocalStorage(database: mockDataBase);

    tEventModel = MockEventModel();
    tEventId = 0;

    when(tEventModel.id).thenReturn(tEventId);
  });

  group('getEventList', () {
    test(
      'should get the list of EventModel from the database',
      () async {
        // arrange
        final List<Map<String, dynamic>> tReturnEventMapList = [
          jsonDecode(fixture('event.json')),
          jsonDecode(fixture('event_min.json')),
        ];
        when(mockDataBase.query(any))
            .thenAnswer((_) async => tReturnEventMapList);

        // act
        final result = await sqfliteLocalStorage.getEventList('events');

        // assert
        final expectedReturnEventList = [
          EventModel.fromMap(jsonDecode(fixture('event.json'))),
          EventModel.fromMap(jsonDecode(fixture('event_min.json'))),
        ];
        verify(mockDataBase.query('events')).called(1);
        expect(result, equals(expectedReturnEventList));
      },
    );
  });

  group('addEvent', () {
    test(
      'should add the EventModel to the database',
      () async {
        // arrange
        final tEventMap = jsonDecode(fixture('event.json'));
        when(tEventModel.toMap()).thenReturn(tEventMap);

        // act
        sqfliteLocalStorage.addEvent('events', tEventModel);

        // assert
        verify(tEventModel.toMap()).called(1);
        verify(mockDataBase.insert(
          'events',
          tEventMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        )).called(1);
      },
    );

    test(
      'should return the id of the EventModel added to the database',
      () async {
        // arrange
        final tEventMap = jsonDecode(fixture('event.json'));
        when(tEventModel.toMap()).thenReturn(tEventMap);
        when(mockDataBase.insert(
          any,
          any,
          conflictAlgorithm: anyNamed('conflictAlgorithm'),
        )).thenAnswer((_) async => tEventId);

        // act
        final result =
            await sqfliteLocalStorage.addEvent('events', tEventModel);

        // assert
        verify(tEventModel.toMap()).called(1);
        verify(mockDataBase.insert(
          'events',
          tEventMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        )).called(1);
        expect(result, equals(tEventId));
      },
    );
  });

  group('deleteEvent', () {
    test(
      'should delete the EventModel from the database',
      () async {
        // act
        sqfliteLocalStorage.deleteEvent('events', tEventModel);

        // assert
        verify(tEventModel.id).called(1);
        verify(mockDataBase.delete(
          'event',
          where: 'id = ?',
          whereArgs: [tEventId],
        )).called(1);
      },
    );
  });

  group('updateEvent', () {
    test(
      'should update the EventModel with the same id in the database',
      () async {
        // arrange
        final tEventMap = jsonDecode(fixture('event.json'));
        when(tEventModel.toMap()).thenReturn(tEventMap);

        // act
        await sqfliteLocalStorage.updateEvent('events', tEventModel);

        // assert
        verify(tEventModel.id).called(1);
        verify(tEventModel.toMap()).called(1);
        verify(mockDataBase.update(
          'event',
          tEventMap,
          where: 'id = ?',
          whereArgs: [tEventId],
        )).called(1);
      },
    );
  });
}
