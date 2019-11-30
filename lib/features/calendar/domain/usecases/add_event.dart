import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class AddEvent extends AsyncUseCase<String, AddEventParams> {
  final EventRepository repository;

  AddEvent({@required this.repository});

  @override
  Future<Either<Failure, String>> call(AddEventParams params) {
    return repository.addEvent(params.event);
  }
}

class AddEventParams extends Equatable {
  final Event event;

  AddEventParams({this.event});

  @override
  List<Object> get props => [event];
}
