class CryptoModel {
  final String id;
  final String symbol;
  final String currencySymbol;
  final String type;
  final String rateUsd;

  CryptoModel({
    required this.id,
    required this.symbol,
    required this.currencySymbol,
    required this.type,
    required this.rateUsd,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'],
      symbol: json['symbol'],
      currencySymbol: json['currencySymbol'] ?? 'N/A',
      type: json['type'],
      rateUsd: json['rateUsd'],
    );
  }
}
