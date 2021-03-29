import 'package:get/get.dart';

import '../controllers/scan_qr_page_controller.dart';

class ScanQrPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanQrPageController>(
      () => ScanQrPageController(),
    );
  }
}
