import 'package:inkly/core/authentication/user.dart';
import 'package:meta/meta.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    @required String name,
    @required DateTime createDateTime,
    String creator,
    List<String> participants,
    DateTime startDateTime,
    DateTime endDateTime,
    String tag,
  }) : super(
          name: name,
          createDateTime: createDateTime,
          creator: creator,
          participants: participants,
          startDateTime: startDateTime,
          endDateTime: endDateTime,
          tag: tag,
        );

  factory EventModel.fromMap(Map<String, dynamic> eventMap) {
    final DateTime startDateTime = eventMap['startDateTime'] == null
        ? null
        : DateTime.parse(eventMap['startDateTime']);
    final DateTime endDateTime = eventMap['endDateTime'] == null
        ? null
        : DateTime.parse(eventMap['endDateTime']);
    final List<String> participants = eventMap['participants'] == null
        ? null
        : eventMap['participants'].cast<String>();
    return EventModel(
      name: eventMap['name'],
      createDateTime: DateTime.parse(eventMap['createDateTime']),
      creator: eventMap['creator'],
      participants: participants,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      tag: eventMap['tag'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'createDateTime':
          createDateTime == null ? null : createDateTime.toIso8601String(),
      'creator': creator,
      'participants': participants,
      'startDateTime':
          startDateTime == null ? null : startDateTime.toIso8601String(),
      'endDateTime': endDateTime == null ? null : endDateTime.toIso8601String(),
      'tag': tag,
    };
  }
}