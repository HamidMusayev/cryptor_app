import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisaz_cryptor/utils/helpers/clipboard.dart';

import '../../../utils/helpers/decryption.dart';

class DecryptorController extends GetxController
    with GetTickerProviderStateMixin {
  final List<Map<String, dynamic>> methods = [
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
    textTxt.addListener(decryptText);
    keyTxt.addListener(decryptText);
    super.onInit();
  }

  void changeMethod(Map<String, dynamic>? val) {
    pickedMethod.value = val!;
    decryptText();
  }

  Future<void> decryptText() async {
    try {
      errorText.value = '';
      if (textTxt.text.isNotEmpty) {
        switch (pickedMethod.value['name']) {
          case 'BASE64':
            cryptTxt.value = DecyptionHelper.fromBASE64(textTxt.text);
            break;
          case 'AES':
            cryptTxt.value = DecyptionHelper.fromAES(
                Encrypted(Uint8List.fromList(utf8.encode(textTxt.text))),
                keyTxt.text);
            break;
          case 'SALSA20':
            cryptTxt.value = DecyptionHelper.fromSalsa20(
                Encrypted(Uint8List.fromList(utf8.encode(textTxt.text))));
            break;
          case 'RSA':
            cryptTxt.value = await DecyptionHelper.fromRSA(
                Encrypted(Uint8List.fromList(utf8.encode(textTxt.text))));
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
