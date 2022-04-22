import 'package:touchandlist/views/calendar/model/event.dart';
import 'package:touchandlist/utils.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [
    Event(
      title: 'Este evento es de prueba',
      description: 'Esta descripción es de prueba',
      from: DateTime.now(),
      to: DateTime.now().add(const Duration(hours: 2)),
    ),
    Event(
      title: 'Evento de 10 horas',
      description: 'Descripción de evento de 10 horas',
      from: DateTime.now(),
      to: DateTime.now().add(const Duration(hours: 10)),
    )
  ];

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events.where(
        (event) {
          final selected = Utils.removeTime(_selectedDate);
          final from = Utils.removeTime(event.from);
          final to = Utils.removeTime(event.to);

          return from.isAtSameMomentAs(selectedDate) ||
              to.isAtSameMomentAs(selectedDate) ||
              (selected.isAfter(from) && selected.isBefore(to));
        },
      ).toList();

  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);

    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);

    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;

    notifyListeners();
  }
}
