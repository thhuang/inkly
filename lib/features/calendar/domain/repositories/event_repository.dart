import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/event.dart';

abstract class EventRepository {
  Either<Failure, Stream<Event>> getEventStream();
  Future<Either<Failure, String>> addEvent(Event event);
  Future<Either<Failure, List<Event>>> getEventList();
  Future<Either<Failure, String>> deleteEvent(Event event);
}
