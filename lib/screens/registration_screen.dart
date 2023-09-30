import 'package:dharohar/cloud_functions/add_user_info.dart';
import 'package:dharohar/constants/colors.dart';
import 'package:dharohar/data/model/user_model.dart';
import 'package:dharohar/screens/email_verify_screen.dart';
import 'package:dharohar/screens/login_screen.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dharohar/widgets/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FocusNode passwordFocusNode = FocusNode();
  Map<String, bool> passwordHas = {
    'length': false,
    'upperCase': false,
    'lowerCase': false,
    'number': false,
    'character': false,
  };

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
      "Create New Account",
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
            focusNode:
                passwordFocusNode, // focus node for the password text field
            onChanged: (password) {
              // checking if the password is strong or not
              isStrongPassword(password);
            },
          ),
        ),
        if (passwordFocusNode.hasFocus)
          // only show the content of the widgets if the password is being entered
          passwordStats(passwordHas),
        const SizedBox(height: 4),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            onPressed: () {
              if (_emailController.text.isNotEmpty &&
                  _passwordController.text.length > 6) {
                registerAndLoginWithEmail(
                        userEmail: _emailController.text,
                        userPassword: _passwordController.text)
                    .then((_) async {
                  final currentUser = await FirebaseAuth.instance.currentUser;
                  final currentUserId = currentUser?.uid ?? "";
                  final currentUserEmail = currentUser?.email ?? "";
                  UserModel user = UserModel(
                    sId: currentUserId,
                    email: currentUserEmail,
                  );
                  print(user);
                  print("calling user info func");
                  addUserInfo(user);
                  print("user info func completed");
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(
                                1.0, 0.0), // Slide from right to left
                            end: Offset.zero,
                          ).animate(animation),
                          child:
                              const EmailVerifyScreen(), // Your destination page
                        );
                      },
                    ),
                  );
                });
              } else {
                debugPrint("LOG: Email is empty or password is invalid.");
              }
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
              // Add more style properties as needed
            ),
            child: const Text(
              "REGISTER",
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
              "Already have an account?",
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
                        LoginScreen(),
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
                "Login here",
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

  Future<void> registerAndLoginWithEmail({
    required String userEmail,
    required String userPassword,
  }) async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      await auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // handling weak-password
        print('Weak password');
      } else if (e.code == 'email-already-in-use') {
        // handling email-already-in-use
        print('Email is already in use');
      } else if (e.code == 'invalid-email') {
        // handling invalid-email
        print('Invalid email');
      }
    }
  }

  void isStrongPassword(String password) {
    // Implement your password strength criteria here

    if (password.length >= 6) {
      passwordHas['length'] = true;
    }
    if (password.contains(RegExp(r'[A-Z]'))) {
      passwordHas['upperCase'] = true;
    }
    if (password.contains(RegExp(r'[a-z]'))) {
      passwordHas['lowerCase'] = true;
    }
    if (password.contains(RegExp(r'[0-9]'))) {
      passwordHas['number'] = true;
    }
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      passwordHas['character'] = true;
    }
  }

  Future<void> VerifyUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    print(user);
    try {
      await user?.sendEmailVerification();
      print("Email verification sent");
    } catch (e) {
      print("Error $e");
    }
  }
}

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [],
    );
  }
}
