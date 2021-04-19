import 'package:enviocrsl/app/modules/scanned_data_page/controllers/scanned_data_page_controller.dart';
import 'package:enviocrsl/app/modules/uploaded_data_list/controllers/uploaded_data_list_controller.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  //
  var tabIndex = 0.obs;
  //

  @override
  void onInit() {
    super.onInit();
    ever(tabIndex, (int tabIndex) {
      if (tabIndex == 1) {
        print(tabIndex.toString());
      } else {
        Get.find<UploadedDataListController>().loadDataFromSheet();
        print("seharusnya ini ngeload sih");
      }
    });
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
