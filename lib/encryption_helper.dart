import 'dart:convert';
import 'package:crypto/crypto.dart';

class EncyptionrHelper {
  static String toMD5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  static String toSHA1(String text) {
    return sha1.convert(utf8.encode(text)).toString();
  }

  static String toSHA256(String text) {
    return sha256.convert(utf8.encode(text)).toString();
  }

  static String toHMAC(String text, String key) {
    var hmacSha256 = Hmac(sha256, utf8.encode(key)); // HMAC-SHA256
    return hmacSha256.convert(utf8.encode(text)).toString();
  }

  static String toBASE64(String text) {
    // String decoded = utf8.decode(base64.decode(encoded));
    return base64.encode(utf8.encode(text));
  }
}
