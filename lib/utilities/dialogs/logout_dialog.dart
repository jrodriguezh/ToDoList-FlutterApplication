import 'package:flutter/material.dart';
import 'package:touchandlist/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Log Out",
    content: "Are you sure you want to log Out?",
    optionBuilder: () => {
      "Cancel": false,
      "Log out": true,
    },
    //In Android u can dismiss the Dialog clicking out of it
    //so we have to controll that with the follow expresion
  ).then(
    (value) => value ?? false,
  );
}
