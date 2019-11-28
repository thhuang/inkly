import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkly/features/calendar/presentation/logicholders/date_time_field_state_notifier.dart';

void main() {
  DateTimeFieldStateNotifier dateTimeFieldStateNotifier;
  List<Tuple3<bool, bool, bool>> stateLog;
  VoidCallback stateListener;

  setUp(() {
    dateTimeFieldStateNotifier = DateTimeFieldStateNotifier();
    stateLog = <Tuple3<bool, bool, bool>>[];
    stateListener = () => stateLog.add(
          Tuple3(
            dateTimeFieldStateNotifier.allDay,
            dateTimeFieldStateNotifier.startFieldSelected,
            dateTimeFieldStateNotifier.endFieldSelected,
          ),
        );
    dateTimeFieldStateNotifier.addListener(stateListener);
  });

  test(
    'should initialize allDay, startFieldSelected, and endFieldSelected to false',
    () async {
      // assert
      expect(dateTimeFieldStateNotifier.allDay, equals(false));
      expect(dateTimeFieldStateNotifier.startFieldSelected, equals(false));
      expect(dateTimeFieldStateNotifier.endFieldSelected, equals(false));
    },
  );

  test(
    'should update allDay and call notifyListeners',
    () async {
      // act
      dateTimeFieldStateNotifier.allDay = !dateTimeFieldStateNotifier.allDay;
      dateTimeFieldStateNotifier.allDay = !dateTimeFieldStateNotifier.allDay;

      // assert
      final expectedStates = [
        Tuple3(true, false, false),
        Tuple3(false, false, false),
      ];
      expect(stateLog, equals(expectedStates));
    },
  );

  test(
    'should update startFieldSelected and call notifyListeners',
    () async {
      // act
      dateTimeFieldStateNotifier.startFieldSelected =
          !dateTimeFieldStateNotifier.startFieldSelected;
      dateTimeFieldStateNotifier.startFieldSelected =
          !dateTimeFieldStateNotifier.startFieldSelected;

      // assert
      final expectedStates = [
        Tuple3(false, true, false),
        Tuple3(false, false, false),
      ];
      expect(stateLog, equals(expectedStates));
    },
  );

  test(
    'should update endFieldSelected and call notifyListeners',
    () async {
      // act
      dateTimeFieldStateNotifier.endFieldSelected =
          !dateTimeFieldStateNotifier.endFieldSelected;
      dateTimeFieldStateNotifier.endFieldSelected =
          !dateTimeFieldStateNotifier.endFieldSelected;

      // assert
      final expectedStates = [
        Tuple3(false, false, true),
        Tuple3(false, false, false),
      ];
      expect(stateLog, equals(expectedStates));
    },
  );

  test(
    'should set startFieldSelected to false when endFieldSelected is updated to true',
    () async {
      // act
      dateTimeFieldStateNotifier.startFieldSelected =
          !dateTimeFieldStateNotifier.startFieldSelected;
      dateTimeFieldStateNotifier.endFieldSelected =
          !dateTimeFieldStateNotifier.endFieldSelected;

      // assert
      final expectedStates = [
        Tuple3(false, true, false),
        Tuple3(false, false, true),
      ];
      expect(stateLog, equals(expectedStates));
    },
  );

  test(
    'should set endFieldSelected to false when startFieldSelected is updated to true',
    () async {
      // act
      dateTimeFieldStateNotifier.endFieldSelected =
          !dateTimeFieldStateNotifier.endFieldSelected;
      dateTimeFieldStateNotifier.startFieldSelected =
          !dateTimeFieldStateNotifier.startFieldSelected;

      // assert
      final expectedStates = [
        Tuple3(false, false, true),
        Tuple3(false, true, false),
      ];
      expect(stateLog, equals(expectedStates));
    },
  );

  test(
    'should set endFieldSelected and startFieldSelected both to false when allDay is updated',
    () async {
      // act
      dateTimeFieldStateNotifier.endFieldSelected =
          !dateTimeFieldStateNotifier.endFieldSelected;
      dateTimeFieldStateNotifier.allDay = !dateTimeFieldStateNotifier.allDay;
      dateTimeFieldStateNotifier.startFieldSelected =
          !dateTimeFieldStateNotifier.startFieldSelected;
      dateTimeFieldStateNotifier.allDay = !dateTimeFieldStateNotifier.allDay;
      dateTimeFieldStateNotifier.startFieldSelected =
          !dateTimeFieldStateNotifier.startFieldSelected;
      dateTimeFieldStateNotifier.allDay = !dateTimeFieldStateNotifier.allDay;
      dateTimeFieldStateNotifier.endFieldSelected =
          !dateTimeFieldStateNotifier.endFieldSelected;
      dateTimeFieldStateNotifier.allDay = !dateTimeFieldStateNotifier.allDay;
      // assert
      final expectedStates = [
        Tuple3(false, false, true),
        Tuple3(true, false, false),
        Tuple3(true, true, false),
        Tuple3(false, false, false),
        Tuple3(false, true, false),
        Tuple3(true, false, false),
        Tuple3(true, false, true),
        Tuple3(false, false, false),
      ];
      expect(stateLog, equals(expectedStates));
    },
  );
}
