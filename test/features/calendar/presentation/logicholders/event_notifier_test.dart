import 'dart:convert';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/features/calendar/data/models/event_model.dart';
import 'package:inkly/features/calendar/domain/entities/event.dart';
import 'package:inkly/features/calendar/presentation/logicholders/event_notifier.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  EventNotifier eventNotifier;
  Event tEvent;
  List<Event> eventLog;
  VoidCallback eventListener;

  setUp(() {
    tEvent = EventModel.fromMap(jsonDecode(fixture('event.json')));
    eventNotifier = EventNotifier(tEvent);
    eventLog = <Event>[];
    eventListener = () => eventLog.add(eventNotifier.event);
    eventNotifier.addListener(eventListener);
  });

  group('constructor', () {
    test(
      'should initialize the state of with a state input',
      () async {
        // assert
        expect(eventNotifier.event, equals(tEvent));
      },
    );
  });

  group('updateEventFields', () {
    test(
      'should update the name of the event and call notifyListeners',
      () async {
        // arrange
        final tName1 = 'test name 1';
        final tName2 = 'test name 2';

        // act
        eventNotifier.updateEventFields(name: tName1);
        eventNotifier.updateEventFields(name: tName2);

        // assert
        final expectedEvent1 = Event(
          name: tName1,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvent2 = Event(
          name: tName2,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvents = [expectedEvent1, expectedEvent2];
        expect(eventLog, expectedEvents);
      },
    );

    test(
      'should update the createDateTime of the event and call notifyListeners',
      () async {
        // arrange
        final tCreateDateTime1 = DateTime(1992, 10, 10);
        final tCreateDateTime2 = DateTime(2019, 11, 27);

        // act
        eventNotifier.updateEventFields(createDateTime: tCreateDateTime1);
        eventNotifier.updateEventFields(createDateTime: tCreateDateTime2);

        // assert
        final expectedEvent1 = Event(
          name: tEvent.name,
          createDateTime: tCreateDateTime1,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvent2 = Event(
          name: tEvent.name,
          createDateTime: tCreateDateTime2,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvents = [expectedEvent1, expectedEvent2];
        expect(eventLog, expectedEvents);
      },
    );

    test(
      'should update the creator of the event and call notifyListeners',
      () async {
        // arrange
        final tCreator1 = 'test creator 1';
        final tCreator2 = 'test creator 2';

        // act
        eventNotifier.updateEventFields(creator: tCreator1);
        eventNotifier.updateEventFields(creator: tCreator2);

        // assert
        final expectedEvent1 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tCreator1,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvent2 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tCreator2,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvents = [expectedEvent1, expectedEvent2];
        expect(eventLog, expectedEvents);
      },
    );

    test(
      'should update the participants of the event and call notifyListeners',
      () async {
        // arrange
        final tParticipants1 = ['participant 0', 'participant 1'];
        final tParticipants2 = ['participant 2', 'participant 3'];

        // act
        eventNotifier.updateEventFields(participants: tParticipants1);
        eventNotifier.updateEventFields(participants: tParticipants2);

        // assert
        final expectedEvent1 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tParticipants1,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvent2 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tParticipants2,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvents = [expectedEvent1, expectedEvent2];
        expect(eventLog, expectedEvents);
      },
    );

    test(
      'should update the startDateTime of the event and call notifyListeners',
      () async {
        // arrange
        final tStartDateTime1 = DateTime(1992, 10, 10);
        final tStartDateTime2 = DateTime(2019, 11, 27);

        // act
        eventNotifier.updateEventFields(startDateTime: tStartDateTime1);
        eventNotifier.updateEventFields(startDateTime: tStartDateTime2);

        // assert
        final expectedEvent1 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tStartDateTime1,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvent2 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tStartDateTime2,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvents = [expectedEvent1, expectedEvent2];
        expect(eventLog, expectedEvents);
      },
    );

    test(
      'should update the endDateTime of the event and call notifyListeners',
      () async {
        // arrange
        final tEndDateTime1 = DateTime(1992, 10, 10);
        final tEndDateTime2 = DateTime(2019, 11, 27);

        // act
        eventNotifier.updateEventFields(endDateTime: tEndDateTime1);
        eventNotifier.updateEventFields(endDateTime: tEndDateTime2);

        // assert
        final expectedEvent1 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEndDateTime1,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvent2 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEndDateTime2,
          allDay: tEvent.allDay,
          note: tEvent.note,
        );
        final expectedEvents = [expectedEvent1, expectedEvent2];
        expect(eventLog, expectedEvents);
      },
    );

    test(
      'should update the allDay of the event and call notifyListeners',
      () async {
        // arrange
        final tAllDay1 = true;
        final tAllDay2 = false;

        // act
        eventNotifier.updateEventFields(allDay: tAllDay1);
        eventNotifier.updateEventFields(allDay: tAllDay2);

        // assert
        final expectedEvent1 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tAllDay1,
          note: tEvent.note,
        );
        final expectedEvent2 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tAllDay2,
          note: tEvent.note,
        );
        final expectedEvents = [expectedEvent1, expectedEvent2];
        expect(eventLog, expectedEvents);
      },
    );

    test(
      'should update the note of the event and call notifyListeners',
      () async {
        // arrange
        final tNote1 = 'test note 1';
        final tNote2 = 'test note 2';

        // act
        eventNotifier.updateEventFields(note: tNote1);
        eventNotifier.updateEventFields(note: tNote2);

        // assert
        final expectedEvent1 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tNote1,
        );
        final expectedEvent2 = Event(
          name: tEvent.name,
          createDateTime: tEvent.createDateTime,
          creator: tEvent.creator,
          participants: tEvent.participants,
          startDateTime: tEvent.startDateTime,
          endDateTime: tEvent.endDateTime,
          allDay: tEvent.allDay,
          note: tNote2,
        );
        final expectedEvents = [expectedEvent1, expectedEvent2];
        expect(eventLog, expectedEvents);
      },
    );
  });
}
