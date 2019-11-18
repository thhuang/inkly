import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/event.dart';

abstract class EventRepository {
  Either<Failure, Stream<Event>> getEventStream();
  Either<Failure, void> addNewEvent();
}
