import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hisaz_cryptor/utils/encrypt_decrypt_helper.dart';

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
    {'name': 'BASE64', 'type': 0},
    {'name': 'AES', 'type': 0},
    {'name': 'SALSA20', 'type': 0},
    {'name': 'RSA', 'type': 0},
  ];

  final _duration = const Duration(milliseconds: 300);
  final _textTxt = TextEditingController();
  final _keyTxt = TextEditingController();

  String _encryptedTxt = '';
  String? _errorText;
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
                autofocus: true,
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
                        child: Row(
                          children: [
                            e['type'] == 1
                                ? const Text(
                                    'HASH',
                                    style: TextStyle(color: Colors.cyan),
                                  )
                                : const Text(
                                    'ENCYRPT',
                                    style: TextStyle(color: Colors.teal),
                                  ),
                            const SizedBox(width: 8),
                            Text(e['name'].toString()),
                          ],
                        ),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (Map<String, dynamic>? val) {
                  setState(() => _pickedMethod = val!);
                  encryptText();
                },
                value: _pickedMethod,
              ),
              const SizedBox(height: 20),
              AnimatedCrossFade(
                crossFadeState: _pickedMethod['name'] == 'HMAC' ||
                        _pickedMethod['name'] == 'AES'
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
              _errorText == null
                  ? SelectableText(
                      _encryptedTxt,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    )
                  : SelectableText(
                      _errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )
            ],
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }

  Future<void> encryptText() async {
    try {
      _errorText = null;
      if (_textTxt.text.isNotEmpty) {
        switch (_pickedMethod['name']) {
          case 'MD5':
            _encryptedTxt = EncyptionHelper.toMD5(_textTxt.text);
            break;
          case 'SHA1':
            _encryptedTxt = EncyptionHelper.toSHA1(_textTxt.text);
            break;
          case 'SHA256':
            _encryptedTxt = EncyptionHelper.toSHA256(_textTxt.text);
            break;
          case 'HMAC':
            _encryptedTxt = EncyptionHelper.toHMAC(_textTxt.text, _keyTxt.text);
            break;
          case 'BASE64':
            _encryptedTxt = EncyptionHelper.toBASE64(_textTxt.text);
            break;
          case 'AES':
            _encryptedTxt =
                EncyptionHelper.toAES(_textTxt.text, _keyTxt.text).base64;
            break;
          case 'SALSA20':
            _encryptedTxt = EncyptionHelper.toSalsa20(_textTxt.text).base64;
            break;
          case 'RSA':
            _encryptedTxt = (await EncyptionHelper.toRSA(_textTxt.text)).base64;
            break;
        }

        setState(() => _isCopied = false);
      }
    } catch (e) {
      setState(() => _errorText = e.toString());
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
