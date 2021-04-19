import 'package:get/get.dart';

import '../controllers/uploaded_data_list_controller.dart';

class UploadedDataListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadedDataListController>(
      () => UploadedDataListController(),
    );
  }
}
