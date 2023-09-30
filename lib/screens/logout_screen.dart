import 'package:dharohar/constants/colors.dart';
import 'package:dharohar/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            signOut();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                AppColor.primaryColor), // Background color
            elevation: MaterialStateProperty.all<double>(4.0), // Elevation
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: AppColor.secondaryColor, // Text color
                fontSize: 16.0, // Font size
              ),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Rounded corners
              ),
            ),
          ),
          child: const Text(
            "LOGOUT",
            style: TextStyle(
              color: AppColor.secondaryColor,
              letterSpacing: 0.7,
            ),
          ),
        ),
      ),
    );
  }

  signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();

    // navigate to LoginScreen() and remove all other stacked screens
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>
            LoginScreen(), // Replace with the desired page
      ),
      (route) => false,
    );
  }
}
