import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateFormatClass {
  DateTime? _date;
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  DateFormatClass();

  DateFormatClass.getDateTime(DateTime date) {
    _date = date;
  }

  DateTime convertTimeStampToDate(Timestamp ts) {
    return ts.toDate();
  }

  String getTodayDateToString() {
    return "${getMonthToName(_date!.month)} ${_date!.day} ${_date!.year}";
  }

  String getMonthToName(int month) {
    return months[month - 1];
  }

  int getMonthNameToMonthValue(String monthName) {
    return months.indexOf(monthName);
  }

  String getCurrentTimeToString() {
    int hour = 0;
    int minute = 0;
    String timeAbbreviation = '';

    hour = _date!.hour > 12 ? _date!.hour - 12 : _date!.hour;
    minute = _date!.minute;
    timeAbbreviation = _date!.hour >= 12 ? "PM" : "AM";

    return "$hour:$minute $timeAbbreviation";
  }

  String getDateWithFormat() {
    //Get day of week example return value: Monday
    return DateFormat('EEEE').format(_date!);
  }

  int getNumberOfDaysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, 12, date.day);

    int nextMonth = firstDayThisMonth.month + 1 < 13
        ? firstDayThisMonth.month + 1
        : (firstDayThisMonth.month + 1) % 12;

    int nextYear = firstDayThisMonth.month + 1 < 13
        ? firstDayThisMonth.year
        : firstDayThisMonth.year + 1;

    var firstDayNextMonth =
        DateTime(nextYear, nextMonth, firstDayThisMonth.day);

    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  List<int> getWeekdaysBaseWeekNeed(DateTime date, int weekNeeded) {
    List<int> targetDaysForWeekNeed = [];
    int numberOfDays = getNumberOfDaysInMonth(date);
    int numberOfdaysInWeek = 7;
    int firstSundayExactDayValue = 0;
    int startingDay = 1;
    int endDay = 0;

    for (var i = 1; i < 7; i++) {
      _date = DateTime(date.year, date.month, i);
      if (getDateWithFormat() == 'Sunday') {
        firstSundayExactDayValue = i;
        break;
      }
    }

    if (weekNeeded > 1) {
      if (weekNeeded < 5) {
        endDay =
            firstSundayExactDayValue + (numberOfdaysInWeek * (weekNeeded - 1));
        startingDay = endDay - 6;
      } else {
        endDay = firstSundayExactDayValue + (numberOfdaysInWeek * 3);
        startingDay = endDay++;
        endDay = numberOfDays;
      }
    } else {
      endDay = firstSundayExactDayValue;
    }

    targetDaysForWeekNeed.add(startingDay);
    targetDaysForWeekNeed.add(endDay);

    return targetDaysForWeekNeed;
  }

  List<int> getNumberOfSundays(DateTime date) {
    List<int> targetDaysForWeekNeed = [];
    int numberOfDays = getNumberOfDaysInMonth(date);

    for (var i = 1; i <= numberOfDays; i++) {
      _date = DateTime(date.year, date.month, i);
      if (getDateWithFormat() == 'Sunday') {
        targetDaysForWeekNeed.add(i);
      }
    }

    targetDaysForWeekNeed.add(numberOfDays);

    return targetDaysForWeekNeed;
  }

  int getCurrentWeek(DateTime date) {
    int numberOfDays = getNumberOfDaysInMonth(date);
    int numberOfSundayWeek = 1;

    for (var i = 1; i < numberOfDays; i++) {
      _date = DateTime(date.year, date.month, i + 1);
      if (getDateWithFormat() == 'Sunday') {
        numberOfSundayWeek++;
      }
      if (date.day == i++) {
        break;
      }
    }

    return numberOfSundayWeek;
  }

  bool isEqualToTargetDate(int month, int day, String dateOfTransactionRecord) {
    _date = DateTime(DateTime.now().year, month, day);

    return dateOfTransactionRecord == getTodayDateToString();
  }

  DateTime convertFirebaseDateStringToLocalDate(String firebaseDate) {
    int month = 1;
    int day = 1;
    int year = 2020;
    int hour = 1;
    int minute = 1;
    String extensionName = "AM";

    // M/D/YTH:M:S AM
    var dateAndTime = firebaseDate.split('T');
    // month/day/year
    var date = dateAndTime[0].split('/');
    var separrateAbbreviation = dateAndTime[1].split(' ');
    var time = separrateAbbreviation[0].split(":");

    month = int.parse(date[0]);
    day = int.parse(date[1]);
    year = int.parse(date[2]);

    hour = int.parse(time[0]);
    minute = int.parse(time[1]);

    extensionName = separrateAbbreviation[1];

    if (!extensionName.contains("AM")) {
      hour += 12;
    }

    return DateTime(year, month, day, hour, minute);
  }

  String getDateTimeConvertedToFirebaseDate() {
    DateTime date = DateTime.now();

    int month = date.month;
    int day = date.day;
    int year = date.year;
    int hour = 1;
    int minute = date.minute;
    String extensionName = "AM";

    if (date.hour > 12) {
      hour = date.hour - 12;
      extensionName = "PM";
    }

    return "$month/$day/${year}T$hour:$minute $extensionName";
  }
}
