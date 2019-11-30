import 'package:sqflite/sqflite.dart';

import '../../features/calendar/data/models/event_model.dart';
import 'local_storage.dart';

const DB_NAME = 'inkly.db';

class SqfliteLocalStorage implements LocalStorage {
  final Database database;

  SqfliteLocalStorage({this.database});

  @override
  Future<int> addEvent(String table, EventModel event) async {
    return await database.insert(
      table,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> deleteEvent(String table, EventModel event) async {
    int id = int.parse(event.id);
    await database.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return id;
  }

  @override
  Future<List<EventModel>> getEventList(String table) async {
    final eventMapList = await database.query(table);
    return eventMapList
        .map((eventMap) => EventModel.fromMap(eventMap))
        .toList();
  }

  @override
  Future<void> updateEvent(String table, EventModel event) async {
    await database.update(
      table,
      event.toMap(),
      where: 'id = ?',
      whereArgs: [int.parse(event.id)],
    );
  }
}
