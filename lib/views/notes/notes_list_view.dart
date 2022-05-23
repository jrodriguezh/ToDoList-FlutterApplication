import 'package:flutter/material.dart';
import 'package:touchandlist/services/cloud/cloud_note.dart';
import '../../utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTap;

  const NotesListView({
    Key? key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notes.isNotEmpty) {
      return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes.elementAt(index);
          return ListTile(
            onTap: () {
              onTap(note);
            },
            textColor: const Color(0xffc0caf5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            selected: false,
            title: Text(
              note.text,
              maxLines: 3,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDeleteNote(note);
                }
              },
              icon: const Icon(Icons.delete),
              color: const Color(0xffc0caf5),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.33,
                child: Image.asset("lib/icons/curly_dotted_arrow.png",
                    color: const Color(
                      0xffc0caf5,
                    )),
              ),
            ),
            const Text(
              "Tap the + icon to start writing your notes!",
              style: TextStyle(color: Color(0xffc0caf5), fontSize: 16),
            ),
          ],
        ),
      );
    }
  }
}
