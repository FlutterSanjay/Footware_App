import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Snackbars {
  // Function to show the snackbar with customizable parameters
  static void showSnackbar({
    required String title,
    required String message,
    Color backgroundColor = Colors.pink,
    Color textColor = Colors.white,
    SnackStyle snackStyle = SnackStyle.FLOATING,
    DismissDirection dismissDirection = DismissDirection.horizontal,
    required IconData fontIcon,
    double borderRadius = 20,
    double margin = 20,
    Curve forwardAnimationCurve = Curves.easeOutBack,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      icon: FaIcon(fontIcon, color: Colors.white),
      snackStyle: snackStyle,
      margin: EdgeInsets.all(margin),
      dismissDirection: dismissDirection,
      borderRadius: borderRadius,
      forwardAnimationCurve: forwardAnimationCurve,
    );
  }
}
