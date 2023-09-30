import 'package:dharohar/constants/colors.dart';
import 'package:dharohar/screens/home_screen.dart';
import 'package:dharohar/screens/registration_screen.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dharohar/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName = "login";

  final List<String> logos = [
    "assets/icons/Facebook_logo.png",
    "assets/icons/Google_logo.png",
    "assets/icons/X_logo.jpg"
  ]; // url of the logo
  final List<Function> functions =
      []; // functions or instructions on what to be done when the button is pressed

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      alwaysShowLeadingAndAction: true,
      alwaysShowTitle: true,
      leading: iconButton(),
      title: title(),
      headerWidget: headerWidget(context),
      body: [
        Container(
          child: body(context),
        ),
      ],
      fullyStretchable: true,
      backgroundColor: Colors.white,
    );
  }

  IconButton iconButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Image.asset(
      "assets/img/registrationScreen_img.png",
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }

  Text title() {
    return const Text(
      "Login in your Account",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 30,
        fontFamily: 'Monsterrat',
      ),
    );
  }

  ListView body(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        const AuthenticationOptions(),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            "or with your email or phone",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black26,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            keyboardType: TextInputType.emailAddress, // Set keyboard type
            controller: _emailController,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'Email', // Label text
              hintText: 'Enter your email', // Placeholder text
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Apply border radius
              ), // Border styling
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            keyboardType: TextInputType.emailAddress, // Set keyboard type
            controller: _passwordController,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password', // Label text
              hintText: 'Enter your password', // Placeholder text
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Apply border radius
              ), // Border styling
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            onPressed: () {
              loginWithEmail(
                userEmail: _emailController.text,
                userPassword: _passwordController.text,
              );
              Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin:
                            const Offset(1.0, 0.0), // Slide from right to left
                        end: Offset.zero,
                      ).animate(animation),
                      child: const HomeScreen(), // Your destination page
                    );
                  },
                ),
                (route) => false,
              );
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
              "Login",
              style: TextStyle(
                color: AppColor.secondaryColor,
                letterSpacing: 0.7,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black26,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        RegistrationScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "Register here",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> loginWithEmail({
    required String userEmail,
    required String userPassword,
  }) async {
    final auth = FirebaseAuth.instance;
    try {
      final UserCredential = auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      print(UserCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // handling user-not-found
        print('User not found');
      } else if (e.code == 'wrong-password') {
        // handling wrong-password
        print("Wrong password");
      }
    }
  }
}
