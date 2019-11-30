import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/storages/sqflite_local_storage.dart';
import 'package:inkly/features/calendar/data/datasources/event_local_data_source.dart';
import 'package:inkly/features/calendar/data/models/event_model.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import '../../fixtures/fixture_reader.dart';

class MockDataBase extends Mock implements Database {}

void main() {
  SqfliteLocalStorage sqfliteLocalStorage;
  MockDataBase mockDataBase;

  setUp(() {
    mockDataBase = MockDataBase();
    sqfliteLocalStorage = SqfliteLocalStorage(database: mockDataBase);
  });

  final tEventMap = jsonDecode(fixture('event.json'));
  final tEventModel = EventModel.fromMap(tEventMap);
  final tEventId = 0;

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
        final result = await sqfliteLocalStorage.getEventList(EVENT_TABLE);

        // assert
        final expectedReturnEventList = [
          EventModel.fromMap(jsonDecode(fixture('event.json'))),
          EventModel.fromMap(jsonDecode(fixture('event_min.json'))),
        ];
        verify(mockDataBase.query(EVENT_TABLE)).called(1);
        expect(result, equals(expectedReturnEventList));
      },
    );
  });

  group('addEvent', () {
    test(
      'should add the EventModel to the database',
      () async {
        // act
        sqfliteLocalStorage.addEvent(EVENT_TABLE, tEventModel);

        // assert
        verify(mockDataBase.insert(
          EVENT_TABLE,
          tEventMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        )).called(1);
      },
    );

    test(
      'should return the id of the EventModel added to the database',
      () async {
        // arrange
        when(mockDataBase.insert(
          any,
          any,
          conflictAlgorithm: anyNamed('conflictAlgorithm'),
        )).thenAnswer((_) async => tEventId);

        // act
        final result =
            await sqfliteLocalStorage.addEvent(EVENT_TABLE, tEventModel);

        // assert
        verify(mockDataBase.insert(
          EVENT_TABLE,
          tEventMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        )).called(1);
        expect(result, equals(tEventId));
      },
    );
  });

  group('deleteEvent', () {
    test(
      'should return the id of the EventModel deleted from the database',
      () async {
        // act
        final result =
            await sqfliteLocalStorage.deleteEvent(EVENT_TABLE, tEventModel);

        // assert
        verify(mockDataBase.delete(
          EVENT_TABLE,
          where: 'id = ?',
          whereArgs: [tEventId],
        )).called(1);
        expect(result, equals(int.parse(tEventModel.id)));
      },
    );
  });

  group('updateEvent', () {
    test(
      'should update the EventModel with the same id in the database',
      () async {
        // arrange

        // act
        await sqfliteLocalStorage.updateEvent('events', tEventModel);

        // assert
        verify(mockDataBase.update(
          EVENT_TABLE,
          tEventMap,
          where: 'id = ?',
          whereArgs: [tEventId],
        )).called(1);
      },
    );
  });
}
