import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharohar/controller/auth_controller.dart';
import 'package:dharohar/constants/constants.dart';
import 'package:dharohar/controller/profile_controller.dart';
import 'package:dharohar/data/model/user_model.dart';
import 'package:dharohar/screens/auth/login_screen.dart';
import 'package:dharohar/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // initializing the profile controller
  var controller = Get.put(ProfileController());

  UserModel user = UserModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var user = snapshot.data!.docs[0];
              return Scrollbar(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(AppColor
                                          .primaryColor), // Background color
                                  elevation: MaterialStateProperty.all<double>(
                                      4.0), // Elevation
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Rounded corners
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Edit your Profile",
                                  style: TextStyle(
                                    color: AppColor.secondaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              ElevatedButton(
                                onPressed: () async {
                                  await Get.put(AuthController())
                                      .signOutMethod(context);
                                  Get.offAll(() => const LoginScreen());
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(AppColor
                                          .primaryColor), // Background color
                                  elevation: MaterialStateProperty.all<double>(
                                      4.0), // Elevation
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Rounded corners
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: AppColor.secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              profilePic(null),
                              const SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(height: 10),
                          userAttributes('Name', user['fullName'] ?? ""),
                          const SizedBox(height: 10),
                          userAttributes('E-mail', user['email'] ?? ""),
                          const SizedBox(height: 10),
                          userAttributes(
                              'Phone Number', user['phoneNumber'] ?? ""),
                          const SizedBox(height: 10),
                          addressAttribute('Address', user['address'] ?? ""),
                          addressAttribute('City', user['city'] ?? ""),
                          addressAttribute('State', user['state'] ?? ""),
                          addressAttribute('Pincode', user['pinCode'] ?? ""),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  TextButton profilePic(String? profilePic) {
    profilePic = profilePic ?? "assets/img/default_profile_pic.jpg";
    return TextButton(
      onPressed: () {},
      child: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 40,
        child: CircleAvatar(
          radius: 38,
          backgroundImage: AssetImage(profilePic),
        ),
      ),
    );
  }

  Column userAttributes(String attributeName, String attributeAddress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          attributeName,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          attributeAddress,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Row addressAttribute(String attributeName, String attributeAddress) {
    return Row(
      children: [
        Text(
          "$attributeName: ",
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          attributeAddress,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
