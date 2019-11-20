import 'package:inkly/features/calendar/domain/entities/event.dart';

class EventListToEventMap {
  // TODO: need refactor!
  Map<DateTime, List<Event>> call(List<Event> eventList) {
    var eventMap = Map<DateTime, List<Event>>();
    eventList.forEach((event) {
      final start = event.startDateTime;
      final end = event.endDateTime;
      final startEntry = DateTime(start.year, start.month, start.day);

      eventMap.update(
        startEntry,
        (dayEventList) => dayEventList + [event],
        ifAbsent: () => [event],
      );

      final overADay = end.difference(start).inMinutes > 1440;
      final inTheSameDay = start.year == end.year &&
          start.month == end.month &&
          start.day == end.day;
      final endAtMidnight = end.hour == 0 && end.minute == 0;
      if (overADay || (!inTheSameDay && !endAtMidnight)) {
        final endEntry = DateTime(end.year, end.month, end.day);
        eventMap.update(
          endEntry,
          (dayEventList) => dayEventList + [event],
          ifAbsent: () => [event],
        );
      }
    });
    return eventMap;
  }
}
