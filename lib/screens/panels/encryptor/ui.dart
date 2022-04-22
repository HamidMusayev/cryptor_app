import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisaz_cryptor/screens/panels/encryptor/controller.dart';
import 'package:hisaz_cryptor/utils/constants.dart';

class EncryptorPanel extends GetView<EncryptorController> {
  const EncryptorPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EncryptorController());
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
              Spaces.vertical20,
              Spaces.vertical20,
              TextField(
                minLines: 1,
                maxLines: 6,
                controller: controller.textTxt,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Şifrələnəcək mətni daxil edin',
                ),
              ),
              Spaces.vertical20,
              Obx(
                () => DropdownButtonFormField(
                  hint: const Text('Şifrələmə alqoritmini seçin'),
                  items: controller.methods
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
                              Spaces.horizontal10,
                              Text(e['name'].toString()),
                            ],
                          ),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: controller.changeMethod,
                  value: controller.pickedMethod.value,
                ),
              ),
              Spaces.vertical20,
              Obx(
                () => AnimatedCrossFade(
                  crossFadeState:
                      controller.pickedMethod.value['name'] == 'HMAC' ||
                              controller.pickedMethod.value['name'] == 'AES'
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                  duration: Durations.ms300,
                  secondChild: Container(),
                  firstChild: TextField(
                    minLines: 1,
                    maxLines: 2,
                    controller: controller.keyTxt,
                    decoration: const InputDecoration(
                      hintText: 'Açarı daxil edin',
                    ),
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
                  Spaces.horizontal10,
                  Obx(
                    () => AnimatedCrossFade(
                      firstChild: TextButton.icon(
                        onPressed: () async => controller.saveToClipboard(),
                        label: const Text('Kopyala'),
                        icon: const Icon(Icons.copy_rounded),
                      ),
                      secondChild: TextButton.icon(
                        onPressed: () async => controller.saveToClipboard(),
                        label: const Text('Kopyalandı'),
                        icon: const Icon(Icons.done_rounded),
                      ),
                      crossFadeState: controller.isCopied.value
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: Durations.ms300,
                    ),
                  )
                ],
              ),
              Spaces.vertical20,
              Obx(
                () => controller.errorText.value == ''
                    ? SelectableText(
                        controller.cryptTxt.value,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      )
                    : SelectableText(
                        controller.errorText.value,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
              )
            ],
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
