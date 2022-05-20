import 'package:touchandlist/views/calendar/model/event.dart';
import 'package:touchandlist/views/calendar/page/event_editing_page.dart';
import 'package:touchandlist/views/calendar/provider/event_provider.dart';
import 'package:touchandlist/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;

  const EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: const CloseButton(),
          actions: buildViewingActions(context, event),
        ),
        body: ListView(
          padding: const EdgeInsets.all(32),
          children: <Widget>[
            buildDateTime(event),
            const SizedBox(height: 32),
            Text(
              event.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              event.description,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      );

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From', event.starts),
        if (!event.isAllDay) buildDate('To', event.ends),
      ],
    );
  }

  Widget buildDate(String title, DateTime date) {
    const styleTitle = TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
    const styleDate = TextStyle(color: Colors.white, fontSize: 18);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(title, style: styleTitle)),
          Text(Utils.toDateTime(date), style: styleDate),
        ],
      ),
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) => [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => EventEditingPage(event: event),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            final provider = Provider.of<EventProvider>(context, listen: false);

            provider.deleteEvent(event);
            Navigator.of(context).pop();
          },
        ),
      ];
}
