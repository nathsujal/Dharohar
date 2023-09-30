import 'package:dharohar/constants/colors.dart';
import 'package:flutter/material.dart';

ElevatedButton customizedElevatedButton(
  VoidCallback onPressed,
  Widget child,
) {
  return ElevatedButton(
    onPressed: () {
      onPressed;
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
          AppColor.primaryColor), // Background color
      elevation: MaterialStateProperty.all<double>(4.0), // Elevation
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
      ),
    ),
    child: child,
  );
}
