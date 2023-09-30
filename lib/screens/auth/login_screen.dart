import 'package:dharohar/controller/auth_controller.dart';
import 'package:dharohar/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  // auth controller
  var controller = Get.put(AuthController());

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => Column(
            children: [
              TextField(),
              TextField(),
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        controller.isLoading(true);
                        await controller
                            .loginMethod(context: context)
                            .then((value) {
                          if (value != null) {
                            print("LoggedIn");
                            Get.offAll(() => const HomeScreen());
                          } else {
                            controller.isLoading(false);
                          }
                        });
                      },
                      child: Text("Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
