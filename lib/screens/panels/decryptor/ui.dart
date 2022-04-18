import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import 'controller.dart';

class DecryptorPanel extends GetView<DecryptorController> {
  const DecryptorPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DecryptorController());
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
                    'Şifrəni aç',
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
                    hintText: 'Şifrəli mətni daxil edin',
                  ),
                ),
                Spaces.vertical20,
                DropdownButtonFormField(
                  hint: const Text('Şifrəni açma alqoritmini seçin'),
                  items: controller.methods
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Row(
                            children: [
                              const Text(
                                'DECYRPT',
                                style: TextStyle(color: Colors.teal),
                              ),
                              Spaces.horizontal10,
                              Text(e['name'].toString()),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: controller.changeMethod,
                  value: controller.pickedMethod.value,
                ),
                Spaces.vertical20,
                Obx(
                  () => AnimatedCrossFade(
                    crossFadeState:
                        controller.pickedMethod.value['name'] == 'AES'
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                    duration: Durations.duration300,
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
                      'Açıq mətn',
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
                          onPressed: () async =>
                              await controller.saveToClipboard(),
                          label: const Text('Kopyala'),
                          icon: const Icon(Icons.copy_rounded),
                        ),
                        secondChild: TextButton.icon(
                          onPressed: () async =>
                              await controller.saveToClipboard(),
                          label: const Text('Kopyalandı'),
                          icon: const Icon(Icons.done_rounded),
                        ),
                        crossFadeState: controller.isCopied.value
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: Durations.duration300,
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
      ),
    );
  }
}
