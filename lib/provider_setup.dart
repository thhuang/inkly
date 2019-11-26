import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'core/storages/local_storage.dart';
import 'core/storages/sqflite_local_storage.dart';
import 'core/utils/event_list_to_event_map.dart';
import 'features/calendar/data/datasources/event_local_data_source.dart';
import 'features/calendar/data/repositories/event_repository_impl.dart';
import 'features/calendar/domain/repositories/event_repository.dart';
import 'features/calendar/domain/usecases/add_event.dart';
import 'features/calendar/domain/usecases/get_event_list.dart';
import 'features/calendar/presentation/logicholders/event_list_notifier.dart';

List<SingleChildCloneableWidget> providers = [
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
  ChangeNotifierProxyProvider3<GetEventList, AddEvent, EventListToEventMap,
      EventListNotifier>(
    builder: (_, getEventList, addEvent, eventListToEventMap, __) =>
        EventListNotifier(
            getEventList: getEventList,
            addEvent: addEvent,
            eventListToEventMap: eventListToEventMap),
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
  Provider<EventListToEventMap>(
    builder: (_) => EventListToEventMap(),
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
