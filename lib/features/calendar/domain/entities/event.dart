import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Event extends Equatable {
  final String name;
  final String creator;
  final List<String> participants;
  final DateTime createDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final bool allDay;
  final String note;

  Event({
    @required this.name,
    @required this.createDateTime,
    this.creator,
    this.participants,
    this.startDateTime,
    this.endDateTime,
    this.allDay,
    this.note,
  })  : assert(name != null),
        assert(createDateTime != null);

  @override
  List<Object> get props => [
        name,
        creator,
        participants,
        createDateTime,
        startDateTime,
        endDateTime,
        allDay,
        note,
      ];
}
