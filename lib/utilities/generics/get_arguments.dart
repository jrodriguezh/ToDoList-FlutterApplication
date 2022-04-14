import 'package:flutter/material.dart';

// We create a function that recives the arguments of the
// next routes, and if they are the type that we are asking for
// we take it, if not, we return null.

extension GetArgument on BuildContext {
  T? getArgument<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
