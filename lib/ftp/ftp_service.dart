import 'dart:io';
import 'package:ftpconnect/ftpconnect.dart';

class FTPService {
  final ftpConnect = FTPConnect(
    '192.168.200.106',
    user: 'HAMIDVS',
    pass: '8520',
    port: 21,
  );

  Future<void> uploadFile(File file) async {
    await ftpConnect.connect();
    bool res = await ftpConnect.uploadFileWithRetry(file, pRetryCount: 2);
    await ftpConnect.disconnect();
  }

  Future<void> downloadFile(String filename, String newFileName) async {
    await ftpConnect.connect();
    bool res =
        await ftpConnect.downloadFileWithRetry(filename, File(newFileName));
    await ftpConnect.disconnect();
  }

  Future<List<FTPEntry>> getFolders(DIR_LIST_COMMAND cmd) async {
    await ftpConnect.connect();
    var res = await ftpConnect.listDirectoryContent(cmd: cmd);
    await ftpConnect.disconnect();
    return res;
  }

  Future<void> getCurrentDirectory() async {
    await ftpConnect.connect();
    var res = await ftpConnect.currentDirectory();
    await ftpConnect.disconnect();
  }
}
