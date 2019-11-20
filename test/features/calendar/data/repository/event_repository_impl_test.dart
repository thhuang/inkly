import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/error/exceptions.dart';
import 'package:inkly/core/error/failures.dart';
import 'package:inkly/features/calendar/data/datasources/event_local_data_source.dart';
import 'package:inkly/features/calendar/data/models/event_model.dart';
import 'package:inkly/features/calendar/data/repositories/event_repository_impl.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockEventLocalDataSource extends Mock implements EventLocalDataSource {}

void main() {
  EventRepositoryImpl repository;
  MockEventLocalDataSource mockEventLocalDataSource;

  setUp(() {
    mockEventLocalDataSource = MockEventLocalDataSource();
    repository = EventRepositoryImpl(localDataSource: mockEventLocalDataSource);
  });

  group('addEvent', () {
    final tEvent = EventModel.fromMap(
      jsonDecode(fixture('event_without_id.json')),
    );

    test(
      'should add the event to local data source',
      () async {
        // act
        repository.addEvent(tEvent);

        // assert
        verify(mockEventLocalDataSource.addEvent(tEvent)).called(1);
      },
    );

    test(
      'should return the id of the event which is added to the local data source when success',
      () async {
        // arrange
        final tEventIdInt = 0;
        final tEventIdString = '0';
        when(mockEventLocalDataSource.addEvent(any))
            .thenAnswer((_) async => tEventIdInt);

        // act
        final result = await repository.addEvent(tEvent);

        // assert
        expect(result, equals(Right(tEventIdString)));
      },
    );

    test('should retruen CacheFailure when getting CacheException', () async {
      // arrange
      when(mockEventLocalDataSource.addEvent(any)).thenThrow(CacheException());

      // act
      final result = await repository.addEvent(tEvent);

      // assert
      expect(result, equals(Left(CacheFailure())));
    });
  });

  group('getEventList', () {
    test(
      'should return the list of events from the local data source',
      () async {
        // arrange
        final tEventList = [
          EventModel.fromMap(jsonDecode(fixture('event.json'))),
          EventModel.fromMap(jsonDecode(fixture('event_min.json'))),
        ];
        when(mockEventLocalDataSource.getEventList())
            .thenAnswer((_) async => tEventList);

        // act
        final result = await repository.getEventList();

        // assert
        verify(mockEventLocalDataSource.getEventList()).called(1);
        expect(result, equals(Right(tEventList)));
      },
    );

    test('should retruen CacheFailure when getting CacheException', () async {
      // arrange
      when(mockEventLocalDataSource.getEventList()).thenThrow(CacheException());

      // act
      final result = await repository.getEventList();

      // assert
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
