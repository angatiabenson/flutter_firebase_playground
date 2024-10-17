import 'package:get/get.dart';

import '../presentation/ui/controllers/version_check_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(VersionCheckController());
  }
}
