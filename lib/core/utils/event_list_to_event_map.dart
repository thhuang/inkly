import '../../features/calendar/domain/entities/event.dart';

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

  Map<DateTime, List<Event>> call(List<Event> eventList) {
    eventList.forEach(
      (event) {
        if (event.startDateTime != null) {
          final endAtMidnight = event.endDateTime.hour == 0 &&
              event.endDateTime.minute == 0 &&
              event.endDateTime.second == 0 &&
              event.endDateTime.millisecond == 0 &&
              event.endDateTime.microsecond == 0;

          final startDate = DateTime(
            event.startDateTime.year,
            event.startDateTime.month,
            event.startDateTime.day,
          );
          final endDate = DateTime(
            event.endDateTime.year,
            event.endDateTime.month,
            endAtMidnight ? event.endDateTime.day - 1 : event.endDateTime.day,
          );

          var currDate = startDate;
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
