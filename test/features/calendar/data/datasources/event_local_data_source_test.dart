import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/error/exceptions.dart';
import 'package:inkly/core/storages/local_storage.dart';
import 'package:inkly/features/calendar/data/datasources/event_local_data_source.dart';
import 'package:inkly/features/calendar/data/models/event_model.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  EventLocalDataSourceImpl dataSource;
  MockLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    dataSource = EventLocalDataSourceImpl(localStorage: mockLocalStorage);
  });

  final tEventModel = EventModel.fromMap(
    jsonDecode(fixture('event.json')),
  );

  group('addEvent', () {
    test(
      'should call LocalStorage to add the event to the database',
      () async {
        // act
        await dataSource.addEvent(tEventModel);

        // assert
        verify(mockLocalStorage.addEvent(EVENT_TABLE, tEventModel)).called(1);
      },
    );

    test(
      'should throw CacheException when insertion failed',
      () async {
        // arrange
        when(mockLocalStorage.addEvent(any, any)).thenThrow(Exception());

        // act
        final call = dataSource.addEvent;

        // assert
        expect(() => call(tEventModel), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('getEventList', () {
    test(
      'should return a list of cached events from the database',
      () async {
        // arrange
        final tEventList = [
          EventModel.fromMap(jsonDecode(fixture('event.json'))),
          EventModel.fromMap(jsonDecode(fixture('event_min.json'))),
        ];
        when(
          mockLocalStorage.getEventList(any),
        ).thenAnswer((_) async => tEventList);

        // act
        final result = await dataSource.getEventList();

        // assert
        verify(mockLocalStorage.getEventList(EVENT_TABLE)).called(1);
        expect(result, equals(tEventList));
      },
    );

    test(
      'should return an empty list if getting null from the database',
      () async {
        // arrange
        when(mockLocalStorage.getEventList(any)).thenAnswer((_) async => null);

        // act
        final result = await dataSource.getEventList();

        // assert
        final expectedList = [];
        expect(result, equals(expectedList));
      },
    );

    test(
      'should throw CacheException if fail to get data from the database',
      () async {
        // arrange
        when(mockLocalStorage.getEventList(any)).thenThrow(Exception());

        // act
        final call = dataSource.getEventList;

        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('deleteEvent', () {
    test(
      'should call LocalStorage to delete the event from the database',
      () async {
        // act
        await dataSource.deleteEvent(tEventModel);

        // assert
        verify(
          mockLocalStorage.deleteEvent(EVENT_TABLE, tEventModel),
        ).called(1);
      },
    );

    test(
      'should throw CacheException when deletion failed',
      () async {
        // arrange
        when(mockLocalStorage.deleteEvent(any, any)).thenThrow(Exception());

        // act
        final call = dataSource.deleteEvent;

        // assert
        expect(() => call(tEventModel), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('updateEvent', () {
    test(
      'should call LocalStorage to update the event in the database',
      () async {
        // act
        await dataSource.updateEvent(tEventModel);

        // assert
        verify(
          mockLocalStorage.updateEvent(EVENT_TABLE, tEventModel),
        ).called(1);
      },
    );

    test(
      'should throw CacheException when update failed',
      () async {
        // arrange
        when(mockLocalStorage.updateEvent(any, any)).thenThrow(Exception());

        // act
        final call = dataSource.updateEvent;

        // assert
        expect(() => call(tEventModel), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });
}
