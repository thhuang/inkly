import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/error/failures.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:inkly/features/calendar/domain/repositories/event_repository.dart';
import 'package:inkly/features/calendar/domain/usecases/delete_event.dart';
import 'package:mockito/mockito.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  DeleteEvent deleteEvent;
  MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    deleteEvent = DeleteEvent(repository: mockEventRepository);
  });

  final tEvent = Event(name: 'test', createDateTime: DateTime(2000));

  test(
    'should forward the call to the repository when success',
    () async {
      // arrange
      final tID = 'index';
      when(mockEventRepository.deleteEvent(any))
          .thenAnswer((_) async => Right(tID));

      // act
      final result = await deleteEvent(Params(event: tEvent));

      // assert
      verify(mockEventRepository.deleteEvent(tEvent)).called(1);
      expect(result, Right(tID));
    },
  );

  test(
    'should forward the call to the repository when failure',
    () async {
      // arrange
      final tFailure = ServerFailure();
      when(mockEventRepository.deleteEvent(any))
          .thenAnswer((_) async => Left(tFailure));

      // act
      final result = await deleteEvent(Params(event: tEvent));

      // assert
      expect(result, Left(tFailure));
    },
  );
}
