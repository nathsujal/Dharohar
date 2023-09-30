import 'package:dharohar/constants/colors.dart';
import 'package:dharohar/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  bool isEmailVerificationButtonClicked = false;

  String currentUserEmail() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userEmail = user?.email ?? "";
    return userEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isEmailVerificationButtonClicked
            ? bodyAfterVerification()
            : bodyForVerification(),
      ),
    );
  }

  Future<void> verifyEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.sendEmailVerification();
  }

  Container bodyForVerification() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 400,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: AppColor.primaryColor.withOpacity(0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Verify your Email",
            style: TextStyle(
              color: AppColor.primaryColor,
              letterSpacing: 0.7,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              child: Image.asset('assets/icons/ic_emailVerification.png')),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(
                                  1.0, 0.0), // Slide from right to left
                              end: Offset.zero,
                            ).animate(animation),
                            child: const HomeScreen(), // Your destination page
                          );
                        },
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.transparent, // Color when tapped
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(0), // Add rounded corners
                    ),
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    verifyEmail();
                    // change the state of the variable
                    // after which the body changes
                    setState(() {
                      isEmailVerificationButtonClicked = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.primaryColor), // Background color
                    elevation:
                        MaterialStateProperty.all<double>(4.0), // Elevation
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded corners
                      ),
                    ),
                  ),
                  child: const Text(
                    "Verify Email",
                    style: TextStyle(
                      color: AppColor.secondaryColor,
                      letterSpacing: 0.7,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container bodyAfterVerification() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 400,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: AppColor.primaryColor.withOpacity(0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "e-mail verification link sent\nto ${currentUserEmail()}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monsterrat',
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 200,
            width: 200,
            child: Image.asset('assets/icons/ic_emailVerification.png'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      const HomeScreen(), // Replace with the desired page
                ),
                (route) => false,
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppColor.primaryColor), // Background color
              elevation: MaterialStateProperty.all<double>(4.0), // Elevation
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                ),
              ),
            ),
            child: const Text(
              "Next",
              style: TextStyle(
                color: AppColor.secondaryColor,
                letterSpacing: 0.7,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
