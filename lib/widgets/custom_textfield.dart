import 'package:flutter/material.dart';

Widget CustomizedTextField(String hintText,String labelText,TextEditingController? controller,bool? obscureText) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: TextField(
      keyboardType: TextInputType.emailAddress, // Set keyboard type
      controller: controller,
      autocorrect: false,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: labelText, // Label text
        hintText: hintText, // Placeholder text
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Apply border radius
        ), // Border styling
      ),
    ),
  );
}
