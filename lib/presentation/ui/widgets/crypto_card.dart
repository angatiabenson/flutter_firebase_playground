import 'package:flutter/material.dart';
import 'package:flutter_firebase_playground/domain/models/crypto_model.dart';


class CryptoCard extends StatelessWidget {
  const CryptoCard({super.key, required this.crypto});

  final CryptoModel crypto;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: crypto.currencySymbol != 'N/A'
            ? Text(
          crypto.currencySymbol,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold),
        )
            : const Icon(Icons.monetization_on),
        title: Text('${crypto.symbol} (${crypto.type})'),
        subtitle: Text('Rate (USD): ${crypto.rateUsd}'),
      ),
    );
  }
}
