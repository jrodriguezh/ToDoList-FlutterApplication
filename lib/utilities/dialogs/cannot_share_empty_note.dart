import 'package:flutter/cupertino.dart';
import 'package:touchandlist/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Sharing",
    content: "You cannot share an empty note!",
    optionBuilder: () => {
      "Ok": null,
    },
  );
}
