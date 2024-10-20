
import 'dart:ui';

import 'package:sheet_client/model/operation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../utils/styles.dart';

class OperationDataSource extends CalendarDataSource {
  OperationDataSource(List<Operation> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].date);
  }

  @override
  DateTime getEndTime(int index) {
    return getStartTime(index).add(Duration(hours: 2));
  }

  @override
  String getSubject(int index) {
    return appointments![index].programName.toString();
  }

  @override
  String getNotes(int index) {
    return appointments![index].programComment.toString();
  }

  @override
  Color getColor(int index) {
    return colorGreenLogo;
  }
}