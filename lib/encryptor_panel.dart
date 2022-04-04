import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hisaz_cryptor/encryption_helper.dart';

class EncryptorPanel extends StatefulWidget {
  const EncryptorPanel({Key? key}) : super(key: key);

  @override
  State<EncryptorPanel> createState() => _EncryptorPanelState();
}

class _EncryptorPanelState extends State<EncryptorPanel> {
  final List<Map<String, dynamic>> _methods = [
    {'name': 'MD5', 'type': 1},
    {'name': 'SHA1', 'type': 1},
    {'name': 'SHA256', 'type': 1},
    {'name': 'HMAC', 'type': 1},
    {'name': 'BASE64', 'type': 1}
  ];

  final _duration = const Duration(milliseconds: 300);
  final _textTxt = TextEditingController();
  final _keyTxt = TextEditingController();

  String _encryptedTxt = '';
  bool _isCopied = false;

  late Map<String, dynamic> _pickedMethod;

  @override
  void initState() {
    _pickedMethod = _methods.first;
    _textTxt.addListener(encryptText);
    _keyTxt.addListener(encryptText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        const Spacer(flex: 1),
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Şifrələyici',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                minLines: 1,
                maxLines: 6,
                controller: _textTxt,
                decoration: const InputDecoration(
                  hintText: 'Şifrələnəcək mətni daxil edin',
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                hint: const Text('Şifrələmə alqoritmini seçin'),
                items: _methods
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e['name'].toString()),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (Map<String, dynamic>? val) {
                  _pickedMethod = val!;
                  encryptText();
                },
                value: _pickedMethod,
              ),
              const SizedBox(height: 20),
              AnimatedCrossFade(
                crossFadeState: _pickedMethod['name'] == 'HMAC'
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: _duration,
                secondChild: Container(),
                firstChild: TextField(
                  minLines: 1,
                  maxLines: 2,
                  controller: _keyTxt,
                  decoration: const InputDecoration(
                    hintText: 'Açarı daxil edin',
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(flex: 1),
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Şifrələnmiş mətn',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  AnimatedCrossFade(
                    firstChild: TextButton.icon(
                      onPressed: () async => await saveToClipboard(),
                      label: const Text('Kopyala'),
                      icon: const Icon(Icons.copy_rounded),
                    ),
                    secondChild: TextButton.icon(
                      onPressed: () async => await saveToClipboard(),
                      label: const Text('Kopyalandı'),
                      icon: const Icon(Icons.done_rounded),
                    ),
                    crossFadeState: _isCopied
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: _duration,
                  )
                ],
              ),
              const SizedBox(height: 20),
              SelectableText(
                _encryptedTxt,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }

  Future<void> encryptText() async {
    if (_textTxt.text.isNotEmpty) {
      switch (_pickedMethod['name']) {
        case 'MD5':
          _encryptedTxt = EncyptionrHelper.toMD5(_textTxt.text);
          break;
        case 'SHA1':
          _encryptedTxt = EncyptionrHelper.toSHA1(_textTxt.text);
          break;
        case 'SHA256':
          _encryptedTxt = EncyptionrHelper.toSHA256(_textTxt.text);
          break;
        case 'HMAC':
          _encryptedTxt = EncyptionrHelper.toHMAC(_textTxt.text, _keyTxt.text);
          break;
        case 'BASE64':
          _encryptedTxt = EncyptionrHelper.toBASE64(_textTxt.text);
          break;
      }

      setState(() => _isCopied = false);
    }
  }

  Future<void> saveToClipboard() async {
    if (_encryptedTxt.isNotEmpty) {
      await Clipboard.setData(
        ClipboardData(text: _encryptedTxt),
      );

      setState(() => _isCopied = true);
    }
  }
}
