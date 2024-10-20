import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheet_client/controller/file_controller.dart';
import 'package:sheet_client/database/calendar_datasource.dart';
import 'package:sheet_client/model/operation.dart';
import 'package:sheet_client/utils/styles.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class CalendarPage extends GetView<FileController> {
  static const String routeName = "/calendar";

  CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: _dataSource(),
          appointmentTimeTextFormat: 'HH:mm',
          monthViewSettings: const MonthViewSettings(showAgenda: true),
          onTap: calendarTapped,
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Operation _meeting = details.appointments![0];

      Get.defaultDialog(
        title: "Operation details",
        middleText: _meeting.programName.toString() +
            "\n" +
            _meeting.programComment.toString() +
            "\nDate: " +
            _meeting.date.toString() +
            "\nOperation Time: " +
            _meeting.programCycleTime.toString(),
        backgroundColor: colorBlueGrey,
        titleStyle: TextStyle(color: colorDarkBlue),
        middleTextStyle: TextStyle(color: colorDarkBlue),
      );
    }
  }

  OperationDataSource _dataSource() {
    List<Operation> list = <Operation>[];
    list = controller.operations;
    return OperationDataSource(list);
  }
}
