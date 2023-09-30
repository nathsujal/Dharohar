import 'package:dharohar/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.changeImage(context);
                },
                child: Text("Change Profile Image"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
