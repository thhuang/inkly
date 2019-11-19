import 'package:sqflite/sqflite.dart';

import '../../features/calendar/data/models/event_model.dart';
import 'local_storage.dart';

class SqfliteLocalStorage implements LocalStorage {
  final Database database;

  SqfliteLocalStorage({this.database});

  @override
  Future<int> addEvent(String key, EventModel event) async {
    return await database.insert(
      key,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteEvent(String key, EventModel event) async {
    await database.delete(
      'event',
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  @override
  Future<List<EventModel>> getEventList(String key) async {
    final eventMapList = await database.query(key);
    return eventMapList
        .map((eventMap) => EventModel.fromMap(eventMap))
        .toList();
  }

  @override
  Future<void> updateEvent(String key, EventModel event) async {
    await database.update(
      'event',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }
}
