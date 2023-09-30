import 'package:dharohar/screens/auth/login_screen.dart';
import 'package:dharohar/screens/home_screen.dart';
import 'package:dharohar/screens/profile/profile_screen.dart';
import 'package:dharohar/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase if you're using it for authentication
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check the user's sign-in status
  bool isSignedIn = checkSignInStatus();

  // Run the app
  runApp(MyApp(isSignedIn: isSignedIn));
}

bool checkSignInStatus() {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  if (user != null) {
    // The user is signed in.
    print("User is signed in with UID: ${user.uid}");
    return true;
  }
  // No user is signed in.
  print("No user is signed in.");
  return false;
}

class MyApp extends StatelessWidget {
  final bool isSignedIn;

  const MyApp({
    super.key,
    required this.isSignedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isSignedIn ? const HomeScreen() : RegistrationScreen(),
    );
  }
}
