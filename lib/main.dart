import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touchandlist/helpers/loading/loading_screen.dart';
import 'package:touchandlist/services/auth/bloc/auth_event.dart';
import 'package:touchandlist/services/auth/bloc/auth_state.dart';
import 'package:touchandlist/services/auth/firebase_auth_provider.dart';
import 'package:touchandlist/views/calendar/page/event_editing_page.dart';
import 'package:touchandlist/views/forgot_password_view.dart';
import 'package:touchandlist/views/home_view.dart';
import 'package:touchandlist/views/register_view.dart';
import 'constants/routes.dart';
import 'services/auth/bloc/auth_bloc.dart';
import 'views/login_view.dart';
import 'views/notes/create_update_note_view.dart';
import 'views/notes/notes_view.dart';
// import 'views/register_view.dart';
import 'views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Touch & List: Calendar Events',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff414868),
        ),
        scaffoldBackgroundColor: const Color(0xff24283b),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          secondary: const Color(0xffc0caf5),
        ),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        // loginRoute: (context) => const LoginView(),
        // registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        // verifyEmailRoute: (context) => const VerifyEmailView(),
        eventEditingPageRoute: (context) => const EventEditingPage(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
              context: context,
              text: state.loadingText ?? "Please wait a moment");
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const HomeView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
