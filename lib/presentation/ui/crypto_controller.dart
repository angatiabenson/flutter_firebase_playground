import 'package:get/get.dart';

import '../../domain/models/crypto_model.dart';
import '../../domain/repo/crypto_repository.dart';

class CryptoController extends GetxController {
  final CryptoRepository repository;
  var isLoading = true.obs;
  var cryptoList = <CryptoModel>[].obs;

  CryptoController(this.repository);

  @override
  void onInit() {
    super.onInit();
    fetchCryptoCurrencies();
  }

  void fetchCryptoCurrencies() async {
    try {
      isLoading(true);
      cryptoList.value = await repository.getCryptoCurrencies();
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading(false);
    }
  }
}
