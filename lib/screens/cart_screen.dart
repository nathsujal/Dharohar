import 'package:dharohar/constants/colors.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondaryColor,
        title: Text(
          "Cart",
          style: TextStyle(
            fontSize: 28,
            color: AppColor.primaryColor,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Add products to cart",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
