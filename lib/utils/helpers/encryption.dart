import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EncyptionHelper {
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
    return base64.encode(utf8.encode(text));
  }

// Modes of operation
// Default mode is SIC AESMode.sic, you can override it using the mode named parameter:
//
// final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
// Supported modes are:
// CBC AESMode.cbc
// CFB-64 AESMode.cfb64
// CTR AESMode.ctr
// ECB AESMode.ecb
// OFB-64/GCTR AESMode.ofb64Gctr
// OFB-64 AESMode.ofb64
// SIC AESMode.sic
// No/zero padding
// To remove padding, pass null to the padding named parameter on the constructor:
//
// final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: null));

  static Encrypted toAES(String text, String key) {
    final k = Key.fromUtf8(key);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(k));
    return encrypter.encrypt(text, iv: iv);
  }

  static Encrypted toSalsa20(String text) {
    final k = Key.fromLength(32);
    final iv = IV.fromLength(8);

    final encrypter = Encrypter(Salsa20(k));
    return encrypter.encrypt(text, iv: iv);
  }

  static Future<Encrypted> toRSA(String text) async {
    final publicKey = await parseKeyFromFile<RSAPublicKey>('test/public.pem');
    final privKey = await parseKeyFromFile<RSAPrivateKey>('test/private.pem');

    final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));
    return encrypter.encrypt(text);
  }

  // Signature and verification
  // RSA
  // final publicKey = await parseKeyFromFile<RSAPublicKey>('test/public.pem');
  // final privateKey = await parseKeyFromFile<RSAPrivateKey>('test/private.pem');
  // final signer = Signer(RSASigner(RSASignDigest.SHA256, publicKey: publicKey, privateKey: privateKey));
  //
  // print(signer.sign('hello world').base64);
  // print(signer.verify64('hello world', 'jfMhNM2v6hauQr6w3ji0xNOxGInHbeIH3DHlpf2W3vmSMyAuwGHG0KLcunggG4XtZrZPAib7oHaKEAdkHaSIGXAtEqaAvocq138oJ7BEznA4KVYuMcW9c8bRy5E4tUpikTpoO+okHdHr5YLc9y908CAQBVsfhbt0W9NClvDWegs='));
}
