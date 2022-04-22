import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:get/get.dart';
import 'package:hisaz_cryptor/screens/panels/uploader/controller.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';

class FolderTile extends GetView<UploaderController> {
  final FTPEntry folder;

  const FolderTile({Key? key, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UploaderController());

    return ListTile(
      onTap: () {},
      leading: SvgPicture.asset('assets/svg/folder_2.svg', width: 50),
      title: Text(folder.name ?? 'null'),
      subtitle: Text(
          '${((folder.size ?? 0) * (9.537 * 0.0000001)).toStringAsFixed(1)} MB - '
          '${DateFormat('dd MMM kk:mm').format(folder.modifyTime ?? DateTime.now())}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Aç',
            onPressed: () {},
            icon: const Icon(
              Icons.navigate_next_rounded,
              color: Colors.orangeAccent,
            ),
          ),
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
            itemBuilder: (BuildContext context) => controller.fileOperations
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
        ],
      ),
    );
  }
}
