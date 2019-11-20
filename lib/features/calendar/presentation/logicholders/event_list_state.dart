import 'package:equatable/equatable.dart';

abstract class EventListState extends Equatable {}

class Uninitialized extends EventListState {
  @override
  List<Object> get props => null;
}

class Loading extends EventListState {
  @override
  List<Object> get props => null;
}

class Loaded extends EventListState {
  @override
  List<Object> get props => null;
}

class Error extends EventListState {
  final String message;

  Error({this.message});

  @override
  List<Object> get props => [message];
}
