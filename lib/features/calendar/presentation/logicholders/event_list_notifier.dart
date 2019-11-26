import 'dart:core';

import 'package:flutter/foundation.dart';
import '../../../../core/utils/event_list_to_event_map.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/event.dart';
import '../../domain/usecases/add_event.dart';
import '../../domain/usecases/get_event_list.dart';
import 'event_list_state.dart';

class EventListNotifier with ChangeNotifier {
  final GetEventList _getEventList;
  final AddEvent _addEvent;
  final EventListToEventMap _eventListToEventMap;

  List<Event> eventList;
  Map<DateTime, List<Event>> eventMap;
  EventListState state = Uninitialized();

  EventListNotifier({
    @required getEventList,
    @required addEvent,
    @required eventListToEventMap,
  })  : assert(getEventList != null),
        assert(addEvent != null),
        assert(eventListToEventMap != null),
        _getEventList = getEventList,
        _addEvent = addEvent,
        _eventListToEventMap = eventListToEventMap;

  Future<void> getEventList() async {
    _loadingStateTransition();
    final eitherFailureOrEvents = await _getEventList(NoParams());
    eitherFailureOrEvents.fold(
      (failure) => _errorStateTransition(_mapFailureToMessage(failure)),
      (events) {
        // TODO: need refactor!
        eventList = events;
        eventMap = _eventListToEventMap(events);
        _loadedStateTransition();
      },
    );
  }

  Future<String> addEvent(Event event) async {
    _loadingStateTransition();
    String eventId;
    final eitherFailureOrId = await _addEvent(Params(event: event));
    await eitherFailureOrId.fold<Future<void>>(
      (failure) async => _errorStateTransition(_mapFailureToMessage(failure)),
      (id) async {
        eventId = id;
        await getEventList();
      },
    );
    return eventId;
  }

  void _loadingStateTransition() {
    if (state != Loading()) {
      state = Loading();
      notifyListeners();
    }
  }

  void _loadedStateTransition() {
    state = Loaded();
    notifyListeners();
  }

  void _errorStateTransition(String message) {
    state = Error(message: message);
    notifyListeners();
  }
}

const String kServerFailureMessage = 'Server Failure';
const String kCacheFailureMessage = 'Cache Failure';

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return kServerFailureMessage;
    case CacheFailure:
      return kCacheFailureMessage;
    default:
      return 'Unexpected error';
  }
}
