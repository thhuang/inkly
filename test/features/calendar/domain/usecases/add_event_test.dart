import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/error/failures.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:inkly/features/calendar/domain/repositories/event_repository.dart';
import 'package:inkly/features/calendar/domain/usecases/add_event.dart';
import 'package:mockito/mockito.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  AddEvent addEvent;
  MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    addEvent = AddEvent(repository: mockEventRepository);
  });

  final tEvent = Event(name: 'test', createDateTime: DateTime(2000));

  test(
    'should forward the call to the repository when success',
    () async {
      // arrange
      final tID = 'index';
      when(mockEventRepository.addEvent(any))
          .thenAnswer((_) async => Right(tID));

      // act
      final result = await addEvent(AddEventParams(event: tEvent));

      // assert
      verify(mockEventRepository.addEvent(tEvent)).called(1);
      expect(result, Right(tID));
    },
  );

  test(
    'should forward the call to the repository when failure',
    () async {
      // arrange
      final tFailure = ServerFailure();
      when(mockEventRepository.addEvent(any))
          .thenAnswer((_) async => Left(tFailure));

      // act
      final result = await addEvent(AddEventParams(event: tEvent));

      // assert
      expect(result, Left(tFailure));
    },
  );
}
