import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touchandlist/constants/routes.dart';
import 'package:touchandlist/enums/menu_action.dart';
import 'package:touchandlist/services/auth/auth_service.dart';
import 'package:touchandlist/services/auth/bloc/auth_bloc.dart';
import 'package:touchandlist/services/auth/bloc/auth_event.dart';
import 'package:touchandlist/services/cloud/cloud_note.dart';
import 'package:touchandlist/services/cloud/firebase_cloud_storage.dart';
import 'package:touchandlist/services/crud/notes_service.dart';
import 'package:touchandlist/views/notes/notes_list_view.dart';

import '../../utilities/dialogs/logout_dialog.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  int index = 0;
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff414868),
        title: const Text("Touch&List"),
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
              }),
              icon: const Icon(Icons.add)),
          PopupMenuButton<menuAction>(onSelected: (value) async {
            switch (value) {
              case menuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                }
                break;
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<menuAction>(
                value: menuAction.logout,
                child: Text("Log Out"),
              ),
            ];
          })
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff24283b),
              Color(0xff414868),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder(
            stream: _notesService.allNotes(ownerUserId: userId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final allNotes = snapshot.data as Iterable<CloudNote>;
                    return NotesListView(
                      notes: allNotes,
                      onDeleteNote: (note) async {
                        await _notesService.deleteNote(
                            docuemntId: note.documentId);
                      },
                      onTap: (note) {
                        Navigator.of(context).pushNamed(
                          createOrUpdateNoteRoute,
                          arguments: note,
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }

                default:
                  return const CircularProgressIndicator();
              }
            }),
      ),
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
          backgroundColor: const Color(0xff24283b),
          height: 70,
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
