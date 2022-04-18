import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CryptorController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabCntr;

  @override
  void onInit() {
    tabCntr = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );

    super.onInit();
  }
}
