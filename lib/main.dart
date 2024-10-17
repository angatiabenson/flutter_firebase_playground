import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/crypto_api.dart';
import 'domain/repo/crypto_repository.dart';
import 'presentation/crypto_page.dart';

void main() {
  Get.put(CryptoRepository(CryptoApi()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CryptoPage(),
    );
  }
}
