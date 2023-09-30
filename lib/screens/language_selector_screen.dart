import 'package:dharohar/constants/colors.dart';
import 'package:dharohar/screens/home_screen.dart';
import 'package:dharohar/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primaryColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Language",
              style: TextStyle(
                fontSize: 20,
                color: AppColor.secondaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200, // Set the desired width
              height: 60, // Set the desired height

              child: ElevatedButton(
                onPressed: () {
                  _changeLanguage(context, "hn");
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColor.primaryColor, // Text color
                  backgroundColor: AppColor.secondaryColor, // Button color
                ),
                child: const Text(
                  'हिन्दी (Hindi)',
                  style: TextStyle(
                    fontSize: 18,
                  ), // Text style
                ),
              ),
            ),
            const SizedBox(height: 16), // Add spacing between buttons
            Container(
              width: 200, // Set the desired width
              height: 60, // Set the desired height
              child: ElevatedButton(
                onPressed: () {
                  _changeLanguage(context, "en");
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColor.primaryColor, // Text color
                  backgroundColor: AppColor.secondaryColor, // Button color
                ),
                child: const Text(
                  'English',
                  style: TextStyle(fontSize: 18), // Text style
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    // Update the app's locale with the selected language
    final newLocale = Locale(languageCode);
    // Use the Intl package to set the app's locale
    Intl.defaultLocale = languageCode;

    // You may want to save the selected language in your app's state or preferences

    // Rebuild the widget tree with the new locale
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => RegistrationScreen(),
    ));
  }
}
