// ignore_for_file: await_only_futures

import 'package:dharohar/cloud_functions/get_user_info.dart';
import 'package:dharohar/constants/colors.dart';
import 'package:dharohar/data/model/user_model.dart';
import 'package:dharohar/screens/account_screen.dart';
import 'package:dharohar/screens/logout_screen.dart';
import 'package:dharohar/screens/order_history_screen.dart';
import 'package:dharohar/screens/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late UserModel user;
  bool detailsFetched = false;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

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
    detailsFetched = true;
    print(user.fullName);
  }

  final String _userProfilePic = "assets/img/default_profile_pic.jpg";
  @override
  Widget build(BuildContext context) {
    if (detailsFetched) {
      return Scaffold(
        body: Column(
          children: [
            Container(
              // shadow under the app bar
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0)
                        .withOpacity(0.8), // Shadow color
                    spreadRadius: 1, // Spread radius of the shadow
                    blurRadius: 2, // Blur radius of the shadow
                    offset: const Offset(0, 0.5), // Offset of the shadow
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Profile(
              userProfilePic: _userProfilePic,
              user: user,
            ),
            const SizedBox(height: 12),
            const DividerInMenu(),
            const OptionsInMenu(
              optionName: "Order History",
              screen: OrderHistoryScreen(),
            ),
            const DividerInMenu(),
            const OptionsInMenu(
              optionName: "Settings",
              screen: SettingsScreen(),
            ),
            const DividerInMenu(),
            const OptionsInMenu(
              optionName: "Logout",
              screen: LogoutScreen(),
            ),
            const DividerInMenu(),
          ],
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}

class OptionsInMenu extends StatelessWidget {
  const OptionsInMenu({
    super.key,
    required this.optionName,
    required this.screen,
  });

  final String optionName;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0), // Slide from right to left
                    end: Offset.zero,
                  ).animate(animation),
                  child: screen, // Your destination page
                );
              },
            ),
          );
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              vertical: 20.0), // Increase the button's height
          foregroundColor:
              AppColor.primaryColor.withOpacity(0.5), // Color when tapped
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Add rounded corners
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              optionName,
              style: const TextStyle(
                fontFamily: 'Monsterrat',
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class DividerInMenu extends StatelessWidget {
  const DividerInMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black.withOpacity(0.5), // Color of the divider line
      thickness: 1.0, // Thickness of the divider
      indent: 40.0, // Left margin of the divider
      endIndent: 40.0, // Right margin of the divider
      height: 0,
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    this.userProfilePic = "",
    required this.user,
  });

  final String userProfilePic;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const SizedBox(width: 30),
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 40,
            child: CircleAvatar(
              radius: 38,
              backgroundImage: AssetImage(userProfilePic),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            width: MediaQuery.of(context).size.width - 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sujal Kumar Nath",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
                Text(
                  "sujalnath14@gmail.com",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                    fontFamily: 'Monsterrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(
                Icons.arrow_forward_ios), // Icon to display in the button
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin:
                            const Offset(1.0, 0.0), // Slide from right to left
                        end: Offset.zero,
                      ).animate(animation),
                      child: AccountScreen(user: user), // Your destination page
                    );
                  },
                ),
              );
            },
            color: AppColor.primaryColor, // Optional: set the color of the icon
            iconSize: 25.0, // Optional: set the size of the icon
          ),
        ],
      ),
    );
  }
}
