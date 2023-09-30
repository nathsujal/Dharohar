import 'package:dharohar/constants/colors.dart';
import 'package:dharohar/data/model/user_model.dart';
import 'package:dharohar/screens/edit_profile_screen.dart';
import 'package:dharohar/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dharohar/cloud_functions/get_user_info.dart';

class AccountScreen extends StatefulWidget {
  final UserModel user;

  const AccountScreen({
    super.key,
    required this.user,
  });

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _AccountScreenState createState() => _AccountScreenState(user: user);
}

class _AccountScreenState extends State<AccountScreen> {
  UserModel user;

  _AccountScreenState({
    required this.user,
  });
  double accountStatus = 0.25;

  Future<void> getUserData() async {
    final currentUser = await FirebaseAuth.instance.currentUser;
    final currentUserId = currentUser?.uid ?? "";
    final currentUserEmail = currentUser?.email ?? "";
    setState(() {
      user = UserModel(
        sId: currentUserId,
        email: currentUserEmail,
      );
    });

    GetUserInfo obj = GetUserInfo();
    user = await obj.getUserInfo(user.sId ?? "", user.email ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: 30.0,
                        lineWidth: 8.0,
                        percent: accountStatus,
                        center: Text(
                          "${accountStatus * 100}%",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: AppColor.primaryColor.withOpacity(0.1),
                        progressColor: AppColor.primaryColor,
                      ),
                      const Text(
                        "Account status",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(
                                    1.0, 0.0), // Slide from right to left
                                end: Offset.zero,
                              ).animate(animation),
                              child: EditProfileScreen(
                                  user: user), // Your destination page
                            );
                          },
                        ),
                      ).then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const HomeScreen(), // Replace with the desired page
                          ),
                          (route) => false));
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
                      "Edit your Profile",
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                      ),
                    ),
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
                  userAttributes('Name', user.fullName ?? ""),
                  const SizedBox(height: 10),
                  userAttributes('E-mail', user.email ?? ""),
                  const SizedBox(height: 10),
                  userAttributes('Phone Number', user.phoneNumber ?? ""),
                  const SizedBox(height: 10),
                  addressAttribute('Address', user.address ?? ""),
                  addressAttribute('City', user.city ?? ""),
                  addressAttribute('State', user.state ?? ""),
                  addressAttribute('Pincode', user.pinCode ?? ""),
                ],
              ),
            ],
          ),
        ),
      ),
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

void reloadCallback() {
  GetUserInfo();
}
