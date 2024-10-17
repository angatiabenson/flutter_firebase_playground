import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateDialogController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Observable for the previous version
  final prevVersion = ''.obs;

  // Animation controller and animation
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  // Callbacks for update actions
  final VoidCallback onUpdate;
  final VoidCallback onLater;

  // Previous version and description
  final String currentVersion;
  final String description;

  UpdateDialogController({
    required this.currentVersion,
    required this.description,
    required this.onUpdate,
    required this.onLater,
  });

  @override
  void onInit() {
    super.onInit();

    // Initialize the animation controller
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Define the scale animation
    scaleAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    // Start the animation
    animationController.forward();

    // Load the current version
    _loadCurrentVersion();
  }

  Future<void> _loadCurrentVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      prevVersion.value = packageInfo.version;
    } catch (e) {
      prevVersion.value = 'Unknown';
    }
  }

  @override
  void onClose() {
    // Dispose the animation controller
    animationController.dispose();
    super.onClose();
  }
}
