import 'package:get/get.dart';
import 'package:hisaz_cryptor/ftp/ftp_service.dart';
import 'package:hisaz_cryptor/models/folder.dart';

class UploaderController extends GetxController {
  RxBool isLoading = false.obs;

  final _service = FTPService();

  List<Folder> folders = [];

  Future<void> getFolders() async {
    isLoading.value = true;
    await _service.getFolders();

    isLoading.value = false;
  }

  @override
  Future<void> onInit() async {
    await getFolders();
    super.onInit();
  }
}
