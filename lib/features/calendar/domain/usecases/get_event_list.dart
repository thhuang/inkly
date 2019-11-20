import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class GetEventList extends AsyncUseCase<List<Event>, NoParams> {
  final EventRepository repository;

  GetEventList({@required this.repository});

  @override
  Future<Either<Failure, List<Event>>> call(NoParams params) async {
    return repository.getEventList();
  }
}
