import 'package:flutter/material.dart';

class DecryptorPanel extends StatefulWidget {
  const DecryptorPanel({Key? key}) : super(key: key);

  @override
  State<DecryptorPanel> createState() => _DecryptorPanelState();
}

class _DecryptorPanelState extends State<DecryptorPanel> {
  final List<String> methods = ['MD5', 'SHA1', 'SHA256', 'HMAC', 'BASE 64'];

  String? pickedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
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
                    'Şifrəni açmaq',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const TextField(
                  minLines: 1,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Şifrələnəcək mətni daxil edin',
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  hint: const Text('Şifrələmə alqoritmini seçin'),
                  items: methods
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (String? val) =>
                      setState(() => pickedMethod = val),
                  value: pickedMethod,
                ),
                const SizedBox(height: 20),
                AnimatedCrossFade(
                  crossFadeState: pickedMethod == 'MD5'
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 800),
                  secondChild: Container(),
                  firstChild: const TextField(
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Açarı daxil edin',
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Şifrələ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.navigate_next_rounded,
                        size: 28,
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                )
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
                      'Şifrəli mətn',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton.icon(
                      onPressed: () {},
                      label: const Text('Kopyala'),
                      icon: const Icon(Icons.copy_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SelectableText('asdasdasdasdasdddsadasdasdsdasdsdsads'),
              ],
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
