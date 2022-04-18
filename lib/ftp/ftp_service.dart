import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:ftpconnect/ftpconnect.dart';

class FTPService {
  final ftpConnect = FTPConnect(
    'hisazdev.az',
    user: 'app@hisazdev.az',
    pass: 'app@hisazdev',
  );

  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (result != null) {
      for (var file in result.files) {
        await ftpConnect.connect();
        bool res = await ftpConnect.uploadFileWithRetry(File(file.path!),
            pRetryCount: 2);
        await ftpConnect.disconnect();
      }
    }
  }

  Future<void> downloadFile(String filename, String newFileName) async {
    await ftpConnect.connect();
    bool res =
        await ftpConnect.downloadFileWithRetry(filename, File(newFileName));
    await ftpConnect.disconnect();
  }

  Future<void> getFolders() async {
    await ftpConnect.connect();
    var res = await ftpConnect.listDirectoryContent();
    await ftpConnect.disconnect();
  }
}
