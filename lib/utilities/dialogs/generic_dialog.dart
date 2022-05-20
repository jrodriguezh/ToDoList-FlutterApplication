import 'package:flutter/material.dart';

// The map create a List of unique Dialogs with Title and optional T,
// that will be the buttons that our Dialogs will require

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionBuilder,
}) {
  final options = optionBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color(0xff24283b),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content:
            Text(content, style: const TextStyle(color: Color(0xffc0caf5))),
        actions: options.keys.map((optionTitle) {
          final T value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}
