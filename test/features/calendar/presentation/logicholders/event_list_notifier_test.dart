import 'dart:convert';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/core/error/failures.dart';
import 'package:inkly/core/usecases/usecase.dart';
import 'package:inkly/core/utils/event_list_to_event_map.dart';
import 'package:inkly/features/calendar/data/models/event_model.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:inkly/features/calendar/domain/usecases/add_event.dart';
import 'package:inkly/features/calendar/domain/usecases/delete_event.dart';
import 'package:inkly/features/calendar/domain/usecases/get_event_list.dart';
import 'package:inkly/features/calendar/presentation/logicholders/event_list_notifier.dart';
import 'package:inkly/features/calendar/presentation/logicholders/event_list_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetEventList extends Mock implements GetEventList {}

class MockAddEvent extends Mock implements AddEvent {}

class MockDeleteEvent extends Mock implements DeleteEvent {}

class MockEventListToEventMap extends Mock implements EventListToEventMap {}

void main() {
  EventListNotifier eventListNotifier;
  MockGetEventList mockGetEventList;
  MockAddEvent mockAddEvent;
  MockDeleteEvent mockDeleteEvent;
  MockEventListToEventMap mockEventListToEventMap;
  List<EventListState> stateLog;
  VoidCallback stateListener;

  setUp(() {
    mockGetEventList = MockGetEventList();
    mockAddEvent = MockAddEvent();
    mockDeleteEvent = MockDeleteEvent();
    mockEventListToEventMap = MockEventListToEventMap();
    eventListNotifier = EventListNotifier(
      getEventList: mockGetEventList,
      addEvent: mockAddEvent,
      deleteEvent: mockDeleteEvent,
      eventListToEventMap: mockEventListToEventMap,
    );
    stateLog = <EventListState>[];
    stateListener = () => stateLog.add(eventListNotifier.state);
    eventListNotifier.addListener(stateListener);
  });

  final tEventList = <Event>[
    EventModel.fromMap(jsonDecode(fixture('event.json'))),
    EventModel.fromMap(jsonDecode(fixture('event_min.json'))),
  ];

  final tEventMap = Map<DateTime, List<Event>>();

  void setUpMockGetEventListSuccess() {
    when(mockGetEventList(any)).thenAnswer((_) async => Right(tEventList));
    when(mockEventListToEventMap(any)).thenReturn(tEventMap);
  }

  void setUpMockGetEventListFailure() =>
      when(mockGetEventList(any)).thenAnswer((_) async => Left(CacheFailure()));

  group('constructor', () {
    test(
      'should initialized the state to Empty',
      () async {
        // assert
        final tEventListState = Uninitialized();
        expect(eventListNotifier.state, equals(tEventListState));
      },
    );
  });

  group('getEventList', () {
    test(
      'should get the event list from GetEventList use case',
      () async {
        // arrange
        setUpMockGetEventListSuccess();

        // act
        eventListNotifier.getEventList();

        // assert
        verify(mockGetEventList(NoParams())).called(1);
      },
    );

    test(
      'should update the state to loading when GetEventList use case is called',
      () async {
        // arrange
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.getEventList();

        // assert
        final expectedState = Loading();
        expect(stateLog[0], expectedState);
      },
    );

    test(
      'should update state from Loading to Loaded and update eventList when data is gotten successfully',
      () async {
        // arrange
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.getEventList();

        // assert
        final expectedStateLog = [Loading(), Loaded()];
        expect(stateLog, expectedStateLog);
        expect(eventListNotifier.eventList, equals(tEventList));
      },
    );

    test(
      'should call EventListToEventMap and update eventMap when data is gotten successfully',
      () async {
        // arrange
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.getEventList();

        // assert
        verify(mockEventListToEventMap(tEventList)).called(1);
        expect(eventListNotifier.eventMap, equals(tEventMap));
      },
    );

    test(
      'should update state to Error when getting data failed',
      () async {
        // arrange
        setUpMockGetEventListFailure();

        // act
        await eventListNotifier.getEventList();

        // exptected
        final expectedStateLog = [
          Loading(),
          Error(message: kCacheFailureMessage),
        ];
        expect(stateLog, expectedStateLog);
      },
    );
  });

  group('addEvent', () {
    final Event tEvent =
        EventModel.fromMap(jsonDecode(fixture('event_without_id.json')));
    final String tEventId = '0';

    void setUpMockAddEventSuccess() =>
        when(mockAddEvent(any)).thenAnswer((_) async => Right(tEventId));

    test(
      'should add the event with AddEvent',
      () async {
        // arrange
        setUpMockAddEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        eventListNotifier.addEvent(tEvent);

        // assert
        verify(mockAddEvent(AddEventParams(event: tEvent))).called(1);
      },
    );

    test(
      'should update the state to Loading when AddEvent use case is called',
      () async {
        // arrange
        setUpMockAddEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.addEvent(tEvent);

        // assert
        final expectedState = Loading();
        expect(stateLog[0], expectedState);
      },
    );

    test(
      'should return the event id from AddEvent when the event is successfully added',
      () async {
        // arrange
        setUpMockAddEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        final result = await eventListNotifier.addEvent(tEvent);

        // assert
        expect(result, equals(tEventId));
      },
    );

    test(
      'should update the state to Error when failing to add the event',
      () async {
        // arrange
        when(mockAddEvent(any)).thenAnswer((_) async => Left(CacheFailure()));

        // act
        await eventListNotifier.addEvent(tEvent);

        // exptected
        final expectedStateLog = [
          Loading(),
          Error(message: kCacheFailureMessage),
        ];
        expect(stateLog, expectedStateLog);
      },
    );

    test(
      'should update the eventList when the event is successfully added',
      () async {
        // arrange
        setUpMockAddEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.addEvent(tEvent);

        // assert
        verify(mockGetEventList(NoParams())).called(1);
        expect(eventListNotifier.eventList, equals(tEventList));
      },
    );

    test(
      'should update the eventMap when the event is successfully added',
      () async {
        // arrange
        setUpMockAddEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.addEvent(tEvent);

        // assert
        verify(mockEventListToEventMap(tEventList)).called(1);
        expect(eventListNotifier.eventMap, equals(tEventMap));
      },
    );

    test(
      'should update state from Loading to Loaded and update eventList when data is gotten successfully',
      () async {
        // arrange
        setUpMockAddEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.addEvent(tEvent);

        // assert
        final expectedStateLog = [Loading(), Loaded()];
        expect(stateLog, expectedStateLog);
        expect(eventListNotifier.eventList, equals(tEventList));
      },
    );

    test(
      'should update state to Error when getting data failed',
      () async {
        // arrange
        setUpMockGetEventListFailure();

        // act
        await eventListNotifier.getEventList();

        // exptected
        final expectedStateLog = [
          Loading(),
          Error(message: kCacheFailureMessage),
        ];
        expect(stateLog, expectedStateLog);
      },
    );
  });

  group('deleteEvent', () {
    final Event tEvent = EventModel.fromMap(jsonDecode(fixture('event.json')));
    final tEventId = tEvent.id;

    void setUpMockDeleteEventSuccess() =>
        when(mockDeleteEvent(any)).thenAnswer((_) async => Right(tEvent.id));

    test(
      'should delete the event with DeleteEvent',
      () async {
        // arrange
        setUpMockDeleteEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        eventListNotifier.deleteEvent(tEvent);

        // assert
        verify(mockDeleteEvent(DeleteEventParams(event: tEvent))).called(1);
      },
    );

    test(
      'should update the state to Loading when DeleteEvent use case is called',
      () async {
        // arrange
        setUpMockDeleteEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.deleteEvent(tEvent);

        // assert
        final expectedState = Loading();
        expect(stateLog[0], expectedState);
      },
    );

    test(
      'should return the event id from DeleteEvent when the event is successfully added',
      () async {
        // arrange
        setUpMockDeleteEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        final result = await eventListNotifier.deleteEvent(tEvent);

        // assert
        expect(result, equals(tEventId));
      },
    );

    test(
      'should update the state to Error when failing to add the event',
      () async {
        // arrange
        when(mockDeleteEvent(any)).thenAnswer((_) async => Left(CacheFailure()));

        // act
        await eventListNotifier.deleteEvent(tEvent);

        // exptected
        final expectedStateLog = [
          Loading(),
          Error(message: kCacheFailureMessage),
        ];
        expect(stateLog, expectedStateLog);
      },
    );

    test(
      'should update the eventList when the event is successfully added',
      () async {
        // arrange
        setUpMockDeleteEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.deleteEvent(tEvent);

        // assert
        verify(mockGetEventList(NoParams())).called(1);
        expect(eventListNotifier.eventList, equals(tEventList));
      },
    );

    test(
      'should update the eventMap when the event is successfully added',
      () async {
        // arrange
        setUpMockDeleteEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.deleteEvent(tEvent);

        // assert
        verify(mockEventListToEventMap(tEventList)).called(1);
        expect(eventListNotifier.eventMap, equals(tEventMap));
      },
    );

    test(
      'should update state from Loading to Loaded and update eventList when data is gotten successfully',
      () async {
        // arrange
        setUpMockDeleteEventSuccess();
        setUpMockGetEventListSuccess();

        // act
        await eventListNotifier.deleteEvent(tEvent);

        // assert
        final expectedStateLog = [Loading(), Loaded()];
        expect(stateLog, expectedStateLog);
        expect(eventListNotifier.eventList, equals(tEventList));
      },
    );

    test(
      'should update state to Error when getting data failed',
      () async {
        // arrange
        setUpMockGetEventListFailure();

        // act
        await eventListNotifier.getEventList();

        // exptected
        final expectedStateLog = [
          Loading(),
          Error(message: kCacheFailureMessage),
        ];
        expect(stateLog, expectedStateLog);
      },
    );
  });
}
