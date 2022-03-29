import 'package:flutter/material.dart';
import 'package:touchandlist/constants/routes.dart';
import 'package:touchandlist/enums/menu_action.dart';
import 'package:touchandlist/services/auth/auth_service.dart';

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Touch&List"),
        actions: [
          PopupMenuButton<menuAction>(onSelected: (value) async {
            switch (value) {
              case menuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  await AuthService.firebase().logOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (_) => false);
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
      body: const Text("Hello World"),
    );
  }
}

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Canel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Log out"),
          )
        ],
      );
    },
  ).then((value) =>
      value ?? false); //If you don't return a value, then return FALSE
}
