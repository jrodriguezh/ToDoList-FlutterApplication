import 'package:flutter/material.dart';
import 'package:touchandlist/constants/routes.dart';
import 'package:touchandlist/enums/menu_action.dart';
import 'package:touchandlist/services/auth/auth_service.dart';
import 'package:touchandlist/services/crud/notes_service.dart';
import 'package:touchandlist/views/notes/notes_list_view.dart';

import '../../utilities/dialogs/logout_dialog.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail {
    // Because the AuthService user could be opcional, we force to it exists with
    //the !! in our App we are forcing users to have an email
    return AuthService.firebase().currentUser!.email!;
  }

  @override
  void initState() {
    _notesService = NotesService();
    _notesService.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  await AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (_) => false,
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
      body: FutureBuilder(
        future: _notesService.getOtCreateUser(email: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                  stream: _notesService.allNotes,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          final allNotes = snapshot.data as List<DatabaseNote>;
                          return NotesListView(
                            notes: allNotes,
                            onDeleteNote: (note) async {
                              await _notesService.deleteNote(id: note.id);
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
                  });
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
