import 'package:touchandlist/views/calendar/model/event_data_source.dart';
import 'package:touchandlist/views/calendar/provider/event_provider.dart';
import 'package:touchandlist/views/calendar/widget/tasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      view: CalendarView.month,
      firstDayOfWeek: 1,
      monthViewSettings: MonthViewSettings(showAgenda: true),
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      todayHighlightColor: const Color.fromARGB(255, 46, 206, 155),
      selectionDecoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 46, 206, 155), width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      cellBorderColor: Colors.transparent,
      onSelectionChanged: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);

        provider.setDate(details.date!);
      },
      onTap: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);

        if (provider.selectedDate == details.date) {
          showModalBottomSheet(
            context: context,
            builder: (context) => const TasksWidget(),
          );
        }
      },
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => const TasksWidget(),
        );
      },
    );
  }
}
