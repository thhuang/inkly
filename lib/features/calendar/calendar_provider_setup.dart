import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/storages/local_storage.dart';
import '../../core/storages/sqflite_local_storage.dart';
import 'data/datasources/event_local_data_source.dart';
import 'data/repositories/event_repository_impl.dart';
import 'domain/repositories/event_repository.dart';
import 'domain/usecases/add_event.dart';
import 'domain/usecases/get_event_list.dart';
import 'presentation/logicholders/event_list_notifier.dart';

List<SingleChildCloneableWidget> calendarProviders = [
  ...externalServices,
  ...coreProviders,
  ...featureProviders,
];

List<SingleChildCloneableWidget> featureProviders = [
  ...dataSourceProviders,
  ...repositoryProviders,
  ...useCaseProviders,
  ...logicHolderProviders,
];

List<SingleChildCloneableWidget> logicHolderProviders = [
  ChangeNotifierProxyProvider2<GetEventList, AddEvent, EventListNotifier>(
    builder: (_, getEventList, addEvent, __) => EventListNotifier(
      getEventList: getEventList,
      addEvent: addEvent,
    ),
  ),
];

List<SingleChildCloneableWidget> useCaseProviders = [
  ProxyProvider<EventRepository, GetEventList>(
    builder: (_, repository, __) => GetEventList(
      repository: repository,
    ),
  ),
  ProxyProvider<EventRepository, AddEvent>(
    builder: (_, repository, __) => AddEvent(
      repository: repository,
    ),
  ),
];

List<SingleChildCloneableWidget> repositoryProviders = [
  ProxyProvider<EventLocalDataSource, EventRepository>(
    builder: (_, localDataSource, __) => EventRepositoryImpl(
      localDataSource: localDataSource,
    ),
  ),
];

List<SingleChildCloneableWidget> dataSourceProviders = [
  ProxyProvider<LocalStorage, EventLocalDataSource>(
    builder: (_, localStorage, __) => EventLocalDataSourceImpl(
      localStorage: localStorage,
    ),
  ),
];

List<SingleChildCloneableWidget> coreProviders = [
  ProxyProvider<Database, LocalStorage>(
    builder: (_, database, __) => SqfliteLocalStorage(
      database: database,
    ),
  ),
];

List<SingleChildCloneableWidget> externalServices = [
  FutureProvider<Database>.value(
    value: getDB(EVENT_TABLE, DB_CREATE_CMD),
  ),
];

Future<Database> getDB(String table, String dbCreateCmd) async {
  Directory documentsDir = await getApplicationDocumentsDirectory();
  String path = p.join(documentsDir.path, DB_NAME);
  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async => await db.execute(dbCreateCmd),
  );
}
