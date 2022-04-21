import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:get/get.dart';
import 'package:hisaz_cryptor/ftp/ftp_service.dart';

class UploaderController extends GetxController {
  final List<Map<String, dynamic>> fileOperations = const [
    {
      'name': 'Adlandır',
      'icon': Icon(Icons.edit_rounded),
    },
    {
      'name': 'Sıxışdır',
      'icon': Icon(Icons.folder_zip_rounded),
    },
    {
      'name': 'Sil',
      'icon': Icon(Icons.delete_rounded, color: Colors.red),
    }
  ];
  RxBool isLoading = false.obs;

  final _service = FTPService();

  List<FTPEntry> folders = [];

  Future<void> getFolders() async {
    isLoading.value = true;
    folders = await _service.getFolders(DIR_LIST_COMMAND.LIST);
    isLoading.value = false;
  }

  Future<void> upload() async {
    isLoading.value = true;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (result != null) {
      for (var file in result.files) {
        File fileToUpload = File(file.path!);
        await _service.uploadFile(fileToUpload);
      }
    }

    isLoading.value = false;
  }

  @override
  Future<void> onInit() async {
    await getFolders();
    super.onInit();
  }
}
