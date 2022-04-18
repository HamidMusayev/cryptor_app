import 'package:flutter/services.dart';

class ClipboardHelper {
  static Future<void> saveToClipboard(String text) async {
    if (text.isNotEmpty) {
      await Clipboard.setData(
        ClipboardData(text: text),
      );
    }
  }
}
