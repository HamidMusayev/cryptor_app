import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:get/get.dart';
import 'package:hisaz_cryptor/utils/constants.dart';
import 'package:intl/intl.dart';

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
          child: const Center(child: CircularProgressIndicator()),
          replacement: ListView.separated(
            itemCount: controller.folders.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => ListTile(
              leading: controller.folders[index].type == FTPEntryType.FILE
                  ? SvgPicture.asset('assets/svg/file.svg', width: 60)
                  : SvgPicture.asset('assets/svg/folder.svg', width: 60),
              title: Text(controller.folders[index].name ?? 'null'),
              subtitle: Text(
                  'Son dəyişiklik: ${DateFormat('dd-MM-yyyy kk:mm').format(controller.folders[index].modifyTime ?? DateTime.now())}, '
                  'Ölçü: ${controller.folders[index].modifyTime}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PopupMenuButton<Map<String, dynamic>>(
                    tooltip: 'Digər',
                    icon: const Icon(Icons.more_vert_rounded),
                    onSelected: (value) {
                      switch (value) {
                        // case 'Sil':
                        //   break;
                        // case 'Adını dəyiş':
                        //   break;
                        // case 'Sıxışdır':
                        //   break;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        controller.fileOperations
                            .map(
                              (e) => PopupMenuItem<Map<String, dynamic>>(
                                value: e,
                                child: Row(
                                  children: [
                                    e['icon'],
                                    Spaces.horizontal10,
                                    Text(e['name']),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
                  TextButton.icon(
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(16)),
                    onPressed: () {},
                    icon: const Icon(Icons.download_rounded),
                    label: const Text('Yüklə'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
