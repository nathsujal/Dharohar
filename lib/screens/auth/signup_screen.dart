import 'package:dharohar/controller/auth_controller.dart';
import 'package:dharohar/constants/constants.dart';
import 'package:dharohar/data/model/user_model.dart';
import 'package:dharohar/screens/home_screen.dart';
import 'package:dharohar/screens/login_screen.dart';
import 'package:dharohar/widgets/authentication_options.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  // text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var reenterPasswordController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  Map<String, bool> passwordHas = {
    'length': false,
    'upperCase': false,
    'lowerCase': false,
    'number': false,
    'character': false,
  };

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
            controller: emailController,
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
            controller: passwordController,
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
        const SizedBox(height: 4),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            onPressed: () async {
              try {
                await controller
                    .signupMethod(
                  email: emailController.text,
                  password: passwordController.text,
                  context: context,
                )
                    .then((value) {
                  UserModel user = UserModel(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  return controller.storeUserData(user);
                }).then((value) {
                  print("LoggedIn Successfully");
                  Get.offAll(() => const HomeScreen());
                });
              } catch (e) {
                auth.signOut();
                print(e.toString());
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
                Get.offAll(LoginScreen());
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
}
