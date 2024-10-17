import '../../data/crypto_api.dart';
import '../models/crypto_model.dart';

class CryptoRepository {
  final CryptoApi api;

  CryptoRepository(this.api);

  Future<List<CryptoModel>> getCryptoCurrencies() async {
    final List<dynamic> rawData = await api.fetchCryptoData();
    return rawData.map((item) => CryptoModel.fromJson(item)).toList();
  }
}
