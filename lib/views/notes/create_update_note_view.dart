import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:touchandlist/services/auth/auth_service.dart';
import 'package:touchandlist/services/cloud/firebase_cloud_storage.dart';
import 'package:touchandlist/utilities/generics/get_arguments.dart';
import 'package:touchandlist/services/cloud/cloud_note.dart';

import '../../utilities/dialogs/cannot_share_empty_note.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _textController = TextEditingController();

    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    await _notesService.updateNote(
      documentId: note.documentId,
      text: text,
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

// Metod to create a new note, checking that the note is unique.

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
// We use the generic get_arguments method created in generics to extract the
// current note if already exist and put it on the textController.
    final widgetNote = context.getArgument<CloudNote>();

    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newNote = await _notesService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmptyOrCanceled() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _notesService.deleteNote(docuemntId: note.documentId);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty && text != "") {
      await _notesService.updateNote(
        documentId: note.documentId,
        text: text,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmptyOrCanceled();
    _saveNoteIfTextNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff414868),
        title: const Text("New Note"),
        actions: [
          IconButton(
            onPressed: () async {
              final text = _textController.text;
              if (_note != null && text.isEmpty) {
                await showCannotShareEmptyNoteDialog(context);
              } else {
                Share.share(text);
              }
            },
            icon: const Icon(Icons.share),
          ),
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
        child: Column(
          children: [
            FutureBuilder(
              future: createOrGetExistingNote(context),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    _setupTextControllerListener();
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _textController,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(color: Colors.white),
                            autofocus: true,
// Advice: maxLines == null makes TextBox Size Increase with
// the text write on it
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Color(0xffc0caf5)),
                              hintText: "Type here your note...",
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        _textController.text = "";
                                        Navigator.maybePop(context);
                                      },
                                      child: const Icon(
                                        Icons.delete_forever_sharp,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        _deleteNoteIfTextIsEmptyOrCanceled();
                                        _saveNoteIfTextNotEmpty();
                                        Navigator.maybePop(context);
                                      },
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  default:
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Container(
                          alignment: Alignment.center,
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
                          child: const CircularProgressIndicator()),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
