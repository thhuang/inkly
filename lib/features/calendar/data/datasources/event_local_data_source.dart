import '../../../../core/error/exceptions.dart';
import '../../../../core/storages/local_storage.dart';
import '../models/event_model.dart';

abstract class EventLocalDataSource {
  /// Get the snapshot of the list of cached [EventModel]s
  /// which are stored in the local database.
  ///
  /// Throws [CacheException] if failure.
  Future<List<EventModel>> getEventList();

  Future<void> addEvent(EventModel event);

  Future<void> updateEvent(EventModel event);

  Future<void> deleteEvent(EventModel event);
}

const EVENT_TABLE = 'events';

class EventLocalDataSourceImpl implements EventLocalDataSource {
  final LocalStorage localStorage;

  EventLocalDataSourceImpl({this.localStorage});

  @override
  Future<void> addEvent(EventModel event) async {
    try {
      await localStorage.addEvent(EVENT_TABLE, event);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteEvent(EventModel event) async {
    try {
      await localStorage.deleteEvent(EVENT_TABLE, event);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<EventModel>> getEventList() async {
    try {
      return await localStorage.getEventList(EVENT_TABLE) ?? [];
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateEvent(EventModel event) async {
    try {
      await localStorage.updateEvent(EVENT_TABLE, event);
    } catch (e) {
      throw CacheException();
    }
  }
}
