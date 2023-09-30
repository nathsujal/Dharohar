import 'package:flutter/material.dart';

final List<String> logos = [
  "assets/icons/Facebook_logo.png",
  "assets/icons/Google_logo.png",
  "assets/icons/X_logo.jpg"
];
// url of the logo
final List<Function> functions = [];
// functions or instructions on what to be done when the button is pressed

class AuthenticationOptions extends StatefulWidget {
  const AuthenticationOptions({super.key});

  @override
  State<AuthenticationOptions> createState() => _AuthenticationOptionsState();
}

class _AuthenticationOptionsState extends State<AuthenticationOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        authenticationButtons(logos[0]),
        const SizedBox(width: 24),
        authenticationButtons(logos[1]),
        const SizedBox(width: 24),
        authenticationButtons(logos[2]),
      ],
    );
  }
}

GestureDetector authenticationButtons(String logoUrl) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 46.0, // Adjust the width and height as needed
      height: 46.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle, // This creates a circular container
        color: Colors.white, // Set the background color of the circle
      ),
      child: Center(
        child: ClipOval(
          child: Image.asset(
            logoUrl, // Replace with your image asset path
            width: 46.0, // Adjust the image size as needed
            height: 46.0,
            fit: BoxFit
                .cover, // Choose how the image should be fitted within the circle
          ),
        ),
      ),
    ),
  );
}
