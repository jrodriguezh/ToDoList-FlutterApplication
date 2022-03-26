import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VeryfyEmailView extends StatefulWidget {
  const VeryfyEmailView({Key? key}) : super(key: key);

  @override
  State<VeryfyEmailView> createState() => _VeryfyEmailViewState();
}

class _VeryfyEmailViewState extends State<VeryfyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email"),
      ),
      body: Column(
        children: [
          const Text("Please verify your email adress"),
          TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text("Send email verification"))
        ],
      ),
    );
  }
}
