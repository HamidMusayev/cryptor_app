import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:get/get.dart';
import 'package:hisaz_cryptor/screens/tabs/uploader/controller.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';

class FileTile extends GetView<UploaderController> {
  final FTPEntry file;

  const FileTile({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UploaderController());

    return ListTile(
      leading: SvgPicture.asset('assets/svg/file.svg', width: 50),
      title: Text(file.name ?? 'null'),
      subtitle: Text(
          '${((file.size ?? 0) * (9.537 * 0.0000001)).toStringAsFixed(1)} MB - '
          '${DateFormat('dd MMM kk:mm').format(file.modifyTime ?? DateTime.now())}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Yüklə',
            onPressed: () async => controller.download(file.name!),
            icon: const Icon(
              Icons.download_rounded,
              color: Colors.green,
            ),
          ),
          PopupMenuButton<Map<String, dynamic>>(
            tooltip: 'Digər',
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) async {
              switch (value['name']) {
                case 'Sil':
                  await controller.delete(file.name!);
                  break;
                case 'Adını dəyiş':
                  break;
                case 'Sıxışdır':
                  break;
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
