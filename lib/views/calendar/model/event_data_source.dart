import 'package:touchandlist/views/calendar/model/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).starts;

  @override
  DateTime getEndTime(int index) => getEvent(index).ends;

  @override
  String getSubject(int index) => getEvent(index).title;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}
