import '../../features/calendar/data/models/event_model.dart';

abstract class LocalStorage {
  Future<List<EventModel>> getEventList(String key);
  Future<int> addEvent(String key, EventModel event);
  Future<void> updateEvent(String key, EventModel event);
  Future<void> deleteEvent(String key, EventModel event);
}
