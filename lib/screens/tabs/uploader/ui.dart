import 'package:flutter/material.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:get/get.dart';
import 'package:hisaz_cryptor/screens/tabs/uploader/file_tile.dart';
import 'package:hisaz_cryptor/utils/constants.dart';

import 'controller.dart';
import 'folder_tile.dart';

class UploaderTab extends GetView<UploaderController> {
  const UploaderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UploaderController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => controller.upload(),
        tooltip: 'Əlavə et',
        child: const Icon(Icons.cloud_upload_rounded),
      ),
      body: Obx(
        () => Visibility(
          visible: controller.isLoading.value,
          child: const Center(child: CircularProgressIndicator()),
          replacement: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Paddings.p14,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  children: const [
                    Icon(
                      Icons.home_rounded,
                      color: Colors.blue,
                    ),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.blue,
                    ),
                    Text('A folder'),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.blue,
                    ),
                    Text('B folder'),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: Paddings.p14,
                  itemCount: controller.folders.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) =>
                      controller.folders[index].type == FTPEntryType.FILE
                          ? FileTile(file: controller.folders[index])
                          : FolderTile(folder: controller.folders[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
