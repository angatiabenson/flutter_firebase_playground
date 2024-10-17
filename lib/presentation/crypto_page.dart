import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'crypto_controller.dart';

class CryptoPage extends StatelessWidget {
  const CryptoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CryptoController controller = Get.put(CryptoController(Get.find()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Rates'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.cryptoList.length,
          itemBuilder: (context, index) {
            final crypto = controller.cryptoList[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: crypto.currencySymbol != 'N/A'
                    ? Text(
                        crypto.currencySymbol,
                        style: TextStyle(fontSize: 24),
                      )
                    : Icon(Icons.monetization_on),
                title: Text('${crypto.symbol} (${crypto.type})'),
                subtitle: Text('Rate (USD): ${crypto.rateUsd}'),
              ),
            );
          },
        );
      }),
    );
  }
}
