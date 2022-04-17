import 'package:flutter/material.dart';
import 'package:hisaz_cryptor/screens/home/panels/decryptor.dart';
import 'package:hisaz_cryptor/screens/home/panels/encryptor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _controller,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            //isScrollable: true,
            tabs: const [
              Tab(
                text: 'HISAZ Encryptor',
                icon: Icon(Icons.lock_outline_rounded),
              ),
              Tab(
                text: 'HISAZ Decryptor',
                icon: Icon(Icons.lock_open_rounded),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: const [
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
