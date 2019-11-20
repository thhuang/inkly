import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/error/failures.dart';
import 'package:inkly/core/usecases/usecase.dart';
import 'package:inkly/features/calendar/data/models/event_model.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:inkly/features/calendar/domain/repositories/event_repository.dart';
import 'package:inkly/features/calendar/domain/usecases/add_event.dart';
import 'package:inkly/features/calendar/domain/usecases/get_event_list.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  GetEventList getEventList;
  MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    getEventList = GetEventList(repository: mockEventRepository);
  });

  test(
    'should forward the call to the repository when success',
    () async {
      // arrange
      final tEventList = <Event>[
        EventModel.fromMap(jsonDecode(fixture('event.json'))),
        EventModel.fromMap(jsonDecode(fixture('event_min.json'))),
      ];
      when(mockEventRepository.getEventList())
          .thenAnswer((_) async => Right(tEventList));

      // act
      final result = await getEventList(NoParams());

      // expect
      verify(mockEventRepository.getEventList()).called(1);
      expect(result, Right(tEventList));
    },
  );

  test(
    'should forward the call to the repository when failure',
    () async {
      // arrange
      final tFailure = CacheFailure();
      when(mockEventRepository.getEventList())
          .thenAnswer((_) async => Left(tFailure));

      // act
      final result = await getEventList(NoParams());

      // assert
      expect(result, equals(Left(tFailure)));
    },
  );
}
