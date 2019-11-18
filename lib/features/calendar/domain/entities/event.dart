import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/authentication/user.dart';

class Event extends Equatable {
  final String name;
  final User creator;
  final List<User> participants;
  final DateTime createDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String tag;

  Event({
    @required this.name,
    this.creator,
    this.participants,
    this.createDateTime,
    this.startDateTime,
    this.endDateTime,
    this.tag,
  });

  @override
  List<Object> get props => null;
}
