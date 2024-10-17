import 'package:flutter/material.dart';
import 'package:flutter_firebase_playground/presentation/ui/controllers/version_check_controller.dart';
import 'package:get/get.dart';

import '../../../domain/models/crypto_model.dart';
import '../../../domain/repo/crypto_repository.dart';
import '../../../util/logger.dart';
import '../update_dialog/update_dialog.dart';

class CryptoController extends GetxController {
  final CryptoRepository repository;
  var isLoading = true.obs;
  var cryptoList = <CryptoModel>[].obs;

  CryptoController(this.repository);

  @override
  void onInit() {
    super.onInit();
    fetchCryptoCurrencies();
    _checkVersion();
  }

  _checkVersion() async {
    final controller = VersionCheckController.instance;
    await controller.checkVersion(
        onVersionChecked: (message, prevVersion, isUpdateRequired) {
      if (isUpdateRequired) {
        _showUpdateDialog(message, prevVersion);
      }
    });
  }

  void fetchCryptoCurrencies() async {
    try {
      isLoading(true);
      cryptoList.value = await repository.getCryptoCurrencies();
    } catch (e) {
      MLogger.debug('Error fetching data: $e');
    } finally {
      isLoading(false);
    }
  }

  _showUpdateDialog(String message, String currentVersion) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => UpdateDialog(
        currentVersion: currentVersion,
        description: message,
        onUpdate: () {
          Navigator.of(context).pop();
        },
        onLater: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
