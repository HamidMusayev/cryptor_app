import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hisaz_cryptor/screens/home/controller.dart';
import 'package:hisaz_cryptor/screens/panels/decryptor/ui.dart';
import 'package:hisaz_cryptor/screens/panels/encryptor/ui.dart';
import 'package:hisaz_cryptor/screens/panels/uploader/ui.dart';

class HomeScreen extends GetView<CryptorController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CryptorController());
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: controller.tabCntr,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            //isScrollable: true,
            tabs: [
              Tab(
                text: 'HISAZ Cloud',
                icon: SvgPicture.asset('assets/svg/cloud.svg', width: 35),
              ),
              Tab(
                text: 'HISAZ Encryptor',
                icon: SvgPicture.asset('assets/svg/encryptor.svg', width: 20),
              ),
              Tab(
                text: 'HISAZ Decryptor',
                icon: SvgPicture.asset('assets/svg/decryptor.svg', width: 40),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabCntr,
              children: const [
                UploaderPanel(),
                EncryptorPanel(),
                DecryptorPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
