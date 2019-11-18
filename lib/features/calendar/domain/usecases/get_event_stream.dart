import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class GetEventStream extends UseCase<Stream<Event>, NoParams> {
  final EventRepository repository;

  GetEventStream({@required this.repository});

  @override
  Either<Failure, Stream<Event>> call(NoParams params) {
    return repository.getEventStream();
  }
}
