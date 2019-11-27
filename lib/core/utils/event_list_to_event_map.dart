import 'package:inkly/features/calendar/domain/entities/event.dart';

class EventListToEventMap {
  var eventMap = Map<DateTime, List<Event>>();

  void _updateEventMap(dateTime, event) {
    eventMap.update(
      dateTime,
      (dayEventList) => dayEventList + [event],
      ifAbsent: () => [event],
    );
  }

  bool _acrossMultipleDays(DateTime start, DateTime end) {
    final overADay = end.difference(start).inMinutes > 1440;
    final inTheSameDay = start.year == end.year &&
        start.month == end.month &&
        start.day == end.day;
    final endAtMidnight = end.hour == 0 && end.minute == 0;
    return overADay || (!inTheSameDay && !endAtMidnight);
  }

  Map<DateTime, List<Event>> call(List<Event> eventList) {
    eventList.forEach(
      (event) {
        if (event.startDateTime != null) {
          final start = event.startDateTime;
          final end = event.endDateTime;

          _updateEventMap(DateTime(start.year, start.month, start.day), event);
          if (_acrossMultipleDays(start, end)) {
            // TODO: should handle cases when start and end across over two days
            _updateEventMap(DateTime(end.year, end.month, end.day), event);
          }
        }
      },
    );
    return eventMap;
  }
}
