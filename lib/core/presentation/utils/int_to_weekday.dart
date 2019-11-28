class IntToWeekday {
  String call(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return null;
    }
  }

  String abbriviation(int day) {
    final weekdayName = call(day);
    return weekdayName != null ? call(day).substring(0, 3) : null;
  }
}
