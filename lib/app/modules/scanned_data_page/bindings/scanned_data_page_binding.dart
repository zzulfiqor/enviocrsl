import 'package:get/get.dart';

import '../controllers/scanned_data_page_controller.dart';

class ScannedDataPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannedDataPageController>(
      () => ScannedDataPageController(),
    );
  }
}
