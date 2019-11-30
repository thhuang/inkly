import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class DeleteEvent extends AsyncUseCase<void, Params> {
  final EventRepository repository;

  DeleteEvent({@required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.deleteEvent(params.event);
  }
}

class Params extends Equatable {
  final Event event;

  Params({this.event});

  @override
  List<Object> get props => [event];
}
