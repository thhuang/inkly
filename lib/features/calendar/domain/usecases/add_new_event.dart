import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class AddNewEvent extends AsyncUseCase<String, Params> {
  final EventRepository repository;

  AddNewEvent({@required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.addNewEvent(params.event);
  }
}

class Params extends Equatable {
  final Event event;

  Params({this.event});

  @override
  List<Object> get props => [event];
}
