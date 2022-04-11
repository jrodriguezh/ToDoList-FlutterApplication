import 'package:flutter/cupertino.dart';
import 'package:touchandlist/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: "An error ocurred",
    content: text,
    optionBuilder: () => {
      "ok": null,
    },
  );
}
