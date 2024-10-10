import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHelperFunctions {

  /// Check is DarkMode
  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Get Screen Height
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }
}
