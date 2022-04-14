import 'package:flutter/material.dart';
import 'package:touchandlist/constants/routes.dart';
import 'package:touchandlist/enums/menu_action.dart';
import 'package:touchandlist/services/auth/auth_service.dart';
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
      body: StreamBuilder(
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
    );
  }
}
