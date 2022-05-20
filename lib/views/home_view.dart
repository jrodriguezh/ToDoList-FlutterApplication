import 'package:flutter/material.dart';
import 'package:touchandlist/views/Calendar/calendar_view.dart';
import 'package:touchandlist/views/notes/notes_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;
  final screens = [
    const NotesView(),
    const CalendarView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xffc0caf5),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 14,
              color: Color(0xffc0caf5),
            ),
          ),
        ),
        child: NavigationBar(
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          backgroundColor: Color(0xff24283b),
          height: MediaQuery.of(context).size.height * 0.11,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(
            () => this.index = index,
          ),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.list, color: Color(0xffc0caf5)),
              selectedIcon: Icon(Icons.list),
              label: "Notes",
            ),
            NavigationDestination(
              icon:
                  Icon(Icons.calendar_month_outlined, color: Color(0xffc0caf5)),
              selectedIcon: Icon(Icons.calendar_month_outlined),
              label: "Calendar",
            ),
          ],
        ),
      ),
    );
  }
}
