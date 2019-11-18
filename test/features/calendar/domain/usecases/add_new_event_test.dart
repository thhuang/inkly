import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/error/failures.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:inkly/features/calendar/domain/repositories/event_repository.dart';
import 'package:inkly/features/calendar/domain/usecases/add_new_event.dart';
import 'package:mockito/mockito.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  AddNewEvent addNewEvent;
  MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    addNewEvent = AddNewEvent(repository: mockEventRepository);
  });

  final tEvent = Event(name: 'test', createDateTime: DateTime(2000));

  test(
    'should pass the call to the repository when success',
    () async {
      // arrange
      final tID = 'index';
      when(mockEventRepository.addNewEvent(any))
          .thenAnswer((_) async => Right(tID));

      // act
      final result = await addNewEvent(Params(event: tEvent));

      // assert
      verify(mockEventRepository.addNewEvent(tEvent)).called(1);
      expect(result, Right(tID));
    },
  );

  test(
    'should pass the call to the repository when failure',
    () async {
      // arrange
      final tFailure = ServerFailure();
      when(mockEventRepository.addNewEvent(any))
          .thenAnswer((_) async => Left(tFailure));

      // act
      final result = await addNewEvent(Params(event: tEvent));

      // assert
      verify(mockEventRepository.addNewEvent(tEvent)).called(1);
      expect(result, Left(tFailure));
    },
  );
}
