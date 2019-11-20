import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/event_local_data_source.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource localDataSource;

  EventRepositoryImpl({this.localDataSource});

  @override
  Future<Either<Failure, String>> addNewEvent(Event event) async {
    try {
      final intId = await localDataSource.addEvent(event);
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
}
