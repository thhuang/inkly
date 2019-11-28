import 'package:flutter/material.dart';

class DateTimeFieldStateNotifier with ChangeNotifier {
  bool _allDay = false;
  bool _startFieldSelected = false;
  bool _endFieldSelected = false;

  bool get allDay => _allDay;
  bool get startFieldSelected => _startFieldSelected;
  bool get endFieldSelected => _endFieldSelected;

  set allDay(bool value) {
    _allDay = value;
    _startFieldSelected = false;
    _endFieldSelected = false;
    notifyListeners();
  }

  set startFieldSelected(bool value) {
    _startFieldSelected = value;
    if (_startFieldSelected) _endFieldSelected = false;
    notifyListeners();
  }

  set endFieldSelected(bool value) {
    _endFieldSelected = value;
    if (_endFieldSelected) _startFieldSelected = false;
    notifyListeners();
  }
}
