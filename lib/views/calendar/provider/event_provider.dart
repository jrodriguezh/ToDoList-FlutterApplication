import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:touchandlist/views/calendar/model/event.dart';
import 'package:touchandlist/utils.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  Future refreshEvents() async {
    notifyListeners();
  }

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events.where(
        (event) {
          final selected = Utils.removeTime(_selectedDate);
          final from = Utils.removeTime(event.starts);
          final to = Utils.removeTime(event.ends);

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

  Future<EventList> getEventList() async {
    EventList eventList = EventList(event: []);
    await FirebaseFirestore.instance.collection("events").get().then(
      (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        eventList = EventList(
            event: querySnapshot.docs
                .map(
                  (e) => Event.fromJson(
                    e.data(),
                  ),
                )
                .toList());
      },
    );
    return eventList;
  }
}
