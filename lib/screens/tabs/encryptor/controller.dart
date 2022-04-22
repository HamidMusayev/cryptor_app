import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/clipboard.dart';
import '../../../utils/helpers/encryption.dart';

class EncryptorController extends GetxController
    with GetTickerProviderStateMixin {
  final List<Map<String, dynamic>> methods = [
    {'name': 'MD5', 'type': 1},
    {'name': 'SHA1', 'type': 1},
    {'name': 'SHA256', 'type': 1},
    {'name': 'HMAC', 'type': 1},
    {'name': 'BASE64', 'type': 0},
    {'name': 'AES', 'type': 0},
    {'name': 'SALSA20', 'type': 0},
    {'name': 'RSA', 'type': 0},
  ];

  final textTxt = TextEditingController();
  final keyTxt = TextEditingController();

  RxString cryptTxt = ''.obs;
  RxString errorText = ''.obs;

  RxBool isCopied = false.obs;

  late Rx<Map<String, dynamic>> pickedMethod =
      Rx<Map<String, dynamic>>(methods.first);

  @override
  void onInit() {
    pickedMethod.value = methods.first;
    textTxt.addListener(encryptText);
    keyTxt.addListener(encryptText);
    super.onInit();
  }

  void changeMethod(Map<String, dynamic>? val) {
    pickedMethod.value = val!;
    encryptText();
  }

  Future<void> encryptText() async {
    try {
      errorText.value = '';
      if (textTxt.text.isNotEmpty) {
        switch (pickedMethod.value['name']) {
          case 'MD5':
            cryptTxt.value = EncyptionHelper.toMD5(textTxt.text);
            break;
          case 'SHA1':
            cryptTxt.value = EncyptionHelper.toSHA1(textTxt.text);
            break;
          case 'SHA256':
            cryptTxt.value = EncyptionHelper.toSHA256(textTxt.text);
            break;
          case 'HMAC':
            cryptTxt.value = EncyptionHelper.toHMAC(textTxt.text, keyTxt.text);
            break;
          case 'BASE64':
            cryptTxt.value = EncyptionHelper.toBASE64(textTxt.text);
            break;
          case 'AES':
            cryptTxt.value =
                EncyptionHelper.toAES(textTxt.text, keyTxt.text).base64;
            break;
          case 'SALSA20':
            cryptTxt.value = EncyptionHelper.toSalsa20(textTxt.text).base64;
            break;
          case 'RSA':
            cryptTxt.value = (await EncyptionHelper.toRSA(textTxt.text)).base64;
            break;
        }

        isCopied.value = false;
      }
    } catch (e) {
      errorText.value = e.toString();
    }
  }

  Future<void> saveToClipboard() async {
    await ClipboardHelper.saveToClipboard(cryptTxt.value);
    isCopied.value = true;
  }
}
