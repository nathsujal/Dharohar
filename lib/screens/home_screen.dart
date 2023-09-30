import 'package:dharohar/constants/colors.dart';
import 'package:dharohar/data/model/user_model.dart';
import 'package:dharohar/screens/Home.dart';
import 'package:dharohar/screens/cart_screen.dart';
import 'package:dharohar/screens/menu_screen.dart';
import 'package:dharohar/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Index of the selected option
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondaryColor,
        elevation: 0,
        title: const Text(
          'Dharohar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
            fontSize: 25,
          ),
        ),
        actions: <Widget>[
          // Add a logo at the top-right corner of the app bar
          Container(
            height: 35,
            width: 70,
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset(
              'assets/logo/ODOP_Initiative_logo.png', // Path to your logo image asset
              width: 65, // Set the desired width
              height: 28, // Set the desired height
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          Home(),
          ProductsScreen(),
          CartScreen(),
          MenuScreen(),
        ],
      ),
      bottomNavigationBar: SlidingClippedNavBar.colorful(
        backgroundColor: AppColor.secondaryColor,
        onButtonPressed: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutQuad,
          );
        },
        iconSize: 30,
        selectedIndex: _currentIndex,
        barItems: [
          BarItem(
            icon: Icons.home_rounded,
            title: "Home",
            activeColor: AppColor.primaryColor,
            inactiveColor: Colors.black,
          ),
          BarItem(
            icon: Icons.inventory_2_rounded,
            title: "Products",
            activeColor: AppColor.primaryColor,
            inactiveColor: Colors.black,
          ),
          BarItem(
            icon: Icons.shopping_cart_rounded,
            title: "Cart",
            activeColor: AppColor.primaryColor,
            inactiveColor: Colors.black,
          ),
          BarItem(
            icon: Icons.menu,
            title: "Menu",
            activeColor: AppColor.primaryColor,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
