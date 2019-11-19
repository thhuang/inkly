import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/error/failures.dart';
import 'package:inkly/core/usecases/usecase.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:inkly/features/calendar/domain/repositories/event_repository.dart';
import 'package:inkly/features/calendar/domain/usecases/get_event_stream.dart';
import 'package:mockito/mockito.dart';

class MockEventRepository extends Mock implements EventRepository {}

class MockEventStream extends Mock implements Stream<Event> {}

void main() {
  GetEventStream getEventStream;
  MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    getEventStream = GetEventStream(repository: mockEventRepository);
  });

  test(
    'should forward the call to the repository when success',
    () async {
      // arrange
      final tEventStream = MockEventStream();
      when(mockEventRepository.getEventStream())
          .thenReturn(Right(tEventStream));

      // act
      final result = getEventStream(NoParams());

      // assert
      verify(mockEventRepository.getEventStream()).called(1);
      expect(result, equals(Right(tEventStream)));
    },
  );

  test(
    'should forward the call to the repository when failure',
    () async {
      // arrange
      final tFailure = ServerFailure();
      when(mockEventRepository.getEventStream()).thenReturn(Left(tFailure));

      // act
      final result = getEventStream(NoParams());

      // assert
      verify(mockEventRepository.getEventStream()).called(1);
      expect(result, equals(Left(tFailure)));
    },
  );
}
