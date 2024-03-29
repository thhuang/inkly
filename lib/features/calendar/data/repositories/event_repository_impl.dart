import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/event_local_data_source.dart';
import '../models/event_model.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource localDataSource;

  EventRepositoryImpl({this.localDataSource});

  @override
  Future<Either<Failure, String>> addEvent(Event event) async {
    try {
      final intId = await localDataSource.addEvent(
        EventModel(
          createDateTime: event.createDateTime,
          name: event.name,
          creator: event.creator,
          participants: event.participants,
          startDateTime: event.startDateTime,
          endDateTime: event.endDateTime,
          allDay: event.allDay,
          note: event.note,
        ),
      );
      return Right(intId.toString());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Stream<Event>> getEventStream() {
    // TODO: implement getEventStream
    return null;
  }

  @override
  Future<Either<Failure, List<Event>>> getEventList() async {
    try {
      return Right(await localDataSource.getEventList());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteEvent(Event event) async {
    try {
      final intId = await localDataSource.deleteEvent(event);
      return Right(intId.toString());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
