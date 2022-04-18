import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class UploaderPanel extends GetView<UploaderController> {
  const UploaderPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UploaderController());
    return Scaffold(
      body: Obx(
        () => Visibility(
          visible: controller.isLoading.value,
          child: Center(child: CircularProgressIndicator()),
          replacement: ListView.separated(
            itemBuilder: (context, index) => ListTile(),
            separatorBuilder: (context, index) => Divider(),
            itemCount: controller.folders.length,
          ),
        ),
      ),
    );
  }
}
