import 'package:flutter/material.dart';
import 'package:touchandlist/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Delete Note",
    content: "Are you sure you want to delete this Note?",
    optionBuilder: () => {
      "Cancel": false,
      "Yes": true,
    },
    //In Android u can dismiss the Dialog clicking out of it
    //so we have to controll that with the follow expresion
  ).then(
    (value) => value ?? false,
  );
}
