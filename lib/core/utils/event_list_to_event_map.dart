import 'package:inkly/features/calendar/domain/entities/event.dart';

class EventListToEventMap {
  var eventMap = Map<DateTime, Set<Event>>();

  void _updateEventMap(DateTime dateTime, Event event) {
    eventMap.update(
      dateTime,
      (dayEventSet) {
        dayEventSet.add(event);
        return dayEventSet;
      },
      ifAbsent: () => {event},
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

          final endAtMidnight = end.hour == 0 &&
              end.minute == 0 &&
              end.second == 0 &&
              end.millisecond == 0 &&
              end.microsecond == 0;
          final endDate = DateTime(
            end.year,
            end.month,
            endAtMidnight ? end.day - 1 : end.day,
          );

          var currDate = DateTime(start.year, start.month, start.day);
          while (!endDate.isBefore(currDate)) {
            _updateEventMap(currDate, event);
            currDate = currDate.add(Duration(days: 1));
          }
        }
      },
    );
    return eventMap.map<DateTime, List<Event>>(
      (dateTime, eventSet) => MapEntry(
        dateTime,
        eventSet.toList(),
      ),
    );
  }
}
