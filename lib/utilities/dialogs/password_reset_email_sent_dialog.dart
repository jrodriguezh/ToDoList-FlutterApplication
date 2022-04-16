import 'package:flutter/cupertino.dart';
import 'package:touchandlist/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Password Reset",
    content:
        "We have now sent you a password reset link. Please Check your email for more information.",
    optionBuilder: () => {
      "Ok": null,
    },
  );
}
