import 'package:flutter/material.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';

class EventNotifier with ChangeNotifier {
  Event event;

  EventNotifier(this.event);

  void updateEventFields({
    String name,
    DateTime createDateTime,
    String creator,
    List<String> participants,
    DateTime startDateTime,
    DateTime endDateTime,
    String note,
  }) {
    if (name != null ||
        createDateTime != null ||
        creator != null ||
        participants != null ||
        startDateTime != null ||
        endDateTime != null ||
        note != null) {
      event = Event(
        name: name ?? event.name,
        createDateTime: createDateTime ?? event.createDateTime,
        creator: creator ?? event.creator,
        participants: participants ?? event.participants,
        startDateTime: startDateTime ?? event.startDateTime,
        endDateTime: endDateTime ?? event.endDateTime,
        note: note ?? event.note,
      );
      notifyListeners();
    }
  }
}
