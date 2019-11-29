import '../../../../core/error/exceptions.dart';
import '../../../../core/storages/local_storage.dart';
import '../models/event_model.dart';

const EVENT_TABLE = 'events';
const DB_CREATE_CMD = '''
  CREATE TABLE $EVENT_TABLE(
    id INTEGER PRIMARY KEY, 
    name TEXT not null, 
    createDateTime TEXT not null,
    creator TEXT,
    participants TEXT,
    startDateTime TEXT,
    endDateTime TEXT,
    allDay INTEGER, 
    note TEXT
  )
''';

abstract class EventLocalDataSource {
  /// Get the snapshot of the list of cached [EventModel]s
  /// which are stored in the local database.
  ///
  /// Throws [CacheException] if failure.
  Future<List<EventModel>> getEventList();

  Future<int> addEvent(EventModel event);

  Future<void> updateEvent(EventModel event);

  Future<void> deleteEvent(EventModel event);
}

class EventLocalDataSourceImpl implements EventLocalDataSource {
  final LocalStorage localStorage;

  EventLocalDataSourceImpl({this.localStorage});

  @override
  Future<int> addEvent(EventModel event) async {
    try {
      return await localStorage.addEvent(EVENT_TABLE, event);
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
