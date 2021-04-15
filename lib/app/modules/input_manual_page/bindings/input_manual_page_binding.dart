import 'package:get/get.dart';

import '../controllers/input_manual_page_controller.dart';

class InputManualPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputManualPageController>(
      () => InputManualPageController(),
    );
  }
}
