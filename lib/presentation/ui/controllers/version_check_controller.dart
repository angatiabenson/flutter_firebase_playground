import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_firebase_playground/util/logger.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionCheckController extends GetxController {
  static VersionCheckController get instance =>
      Get.find<VersionCheckController>();

  String updateMessage = '';

  Future<void> checkVersion(
      {required Function(String, String, bool) onVersionChecked}) async {
    try {
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ));
      await remoteConfig.fetchAndActivate();

      String minRequiredVersion =
          remoteConfig.getString('requiredMinimumVersion');
      String appVersion = (await PackageInfo.fromPlatform()).version;

      if (_isVersionOutdated(appVersion, minRequiredVersion)) {
        updateMessage = remoteConfig.getString('force_update_message');
        onVersionChecked(updateMessage, minRequiredVersion, true);
      }
      onVersionChecked('', '', false);
    } catch (e) {
      MLogger.debug('Error fetching Remote Config: $e');
      rethrow;
    }
  }

  bool _isVersionOutdated(String currentVersion, String minVersion) {
    List<String> currentParts = currentVersion.split('.');
    List<String> minParts = minVersion.split('.');

    for (int i = 0; i < minParts.length; i++) {
      int current = int.parse(currentParts[i]);
      int minimum = int.parse(minParts[i]);
      if (current < minimum) return true;
      if (current > minimum) return false;
    }
    return false;
  }
}
