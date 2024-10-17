import 'package:flutter/material.dart';
import 'package:flutter_firebase_playground/presentation/ui/widgets/crypto_card.dart';
import 'package:get/get.dart';

import 'crypto_controller.dart';

class CryptoPage extends StatelessWidget {
  const CryptoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CryptoController controller = Get.put(CryptoController(Get.find()));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto Rates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.cryptoList.length,
          itemBuilder: (context, index) {
            final crypto = controller.cryptoList[index];
            return CryptoCard(crypto: crypto);
          },
        );
      }),
    );
  }
}
