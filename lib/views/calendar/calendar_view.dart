import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touchandlist/views/calendar/provider/event_provider.dart';
import "package:touchandlist/views/calendar/widget/calendar_widget.dart";
import 'package:touchandlist/views/calendar/page/event_editing_page.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Touch&List: Calendar Events",
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xff24283b),
            // primaryColor: Colors.red,
          ),
          home: const MainPage(),
        ),
      );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Touch&List: Calendar Events",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              )),
          backgroundColor: const Color(0xff414868),
          centerTitle: true,
        ),
        body: const CalendarWidget(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 46, 206, 155),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const EventEditingPage()),
          ),
        ),
      );
}
