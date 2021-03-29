import 'package:enviocrsl/app/data/db/database.dart';
import 'package:enviocrsl/app/modules/home_page/controllers/home_page_controller.dart';
import 'package:enviocrsl/app/modules/scan_qr_page/controllers/scan_qr_page_controller.dart';
import 'package:enviocrsl/app/modules/scanned_data_page/controllers/scanned_data_page_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var dbHelper;
  var countNotSubmitted = 0;

  @override
  void onInit() {
    super.onInit();
    this.dbHelper = DBHelper();
  }

  var tabIndex = 0;

  void changeTabIndex(int index) {
    if (index == 1) {
      Get.find<ScanQrPageController>().isTabOpen.value = true;
      tabIndex = index;
      update();
    } else if (index == 2) {
      getNotSUbmittedItemLength();
      Get.find<ScanQrPageController>().isTabOpen.value = false;
      Get.find<ScannedDataPageController>().loadScannedData();
      Get.find<ScannedDataPageController>().getNotSUbmittedItemLength();
      tabIndex = index;
      update();
    } else {
      Get.find<ScanQrPageController>().isTabOpen.value = false;
      Get.find<HomePageController>().loadDataFromSheet();
      tabIndex = index;
      update();
    }
  }

  void getNotSUbmittedItemLength() async {
    var count = await dbHelper.getNoSubmittedDataCount();
    this.countNotSubmitted = count;
    update();
  }
}
