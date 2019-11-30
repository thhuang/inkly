import '../../features/calendar/domain/entities/event.dart';

class EventComparator {
  int call(Event e1, Event e2) =>
      e1.allDay ?? false || e1.startDateTime.isBefore(e2.startDateTime) ? 0 : 1;
}
