import 'package:get/get_utils/get_utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class Spaces {
  Spaces._();

  static const vertical20 = SizedBox(height: 20);
  static const horizontal10 = SizedBox(width: 10);
}

class Durations {
  Durations._();

  static const ms300 = Duration(milliseconds: 300);
  static const m30 = Duration(minutes: 30);
}

class Paddings {
  Paddings._();
  static const p14 = EdgeInsets.all(14);
  static const p24 = EdgeInsets.all(24);
}

class Snacks {
  Snacks._();
  static GetSnackBar success(String title, String message, IconData iconData,
      {Duration? duration}) {
    return GetSnackBar(
      title: title,
      message: message,
      padding: Paddings.p24,
      margin: Paddings.p24,
      duration: duration ?? const Duration(milliseconds: 3000),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade600,
      borderRadius: 10,
      icon: Icon(
        iconData,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
