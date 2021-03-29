import 'package:enviocrsl/app/data/db/database.dart';
import 'package:enviocrsl/app/data/models/ScannedData.dart';
import 'package:enviocrsl/app/modules/home/controllers/home_controller.dart';
import 'package:enviocrsl/app/modules/scanned_data_page/controllers/scanned_data_page_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPageController extends GetxController {
  QRViewController qrViewController;
  var dbHelper;
  @override
  void onInit() {
    super.onInit();
    this.dbHelper = DBHelper();
  }

  var isTabOpen = false.obs;
  var isSubmitError = false.obs;
  var isFlashOn = false.obs;
  var isDialogLoading = false.obs;

  var dataFromQr = "";

  var dataNo = '-'.obs;
  var dataNama = '-'.obs;
  var dataEkspedisi = '-'.obs;

  var regexNo = RegExp(r'[^0-9]+');
  var regexBracket = RegExp(r'\[|\]');

  void setDataFromQr(String data) {
    this.dataFromQr = data;
    update();
  }

  void toggleFlashStatus(bool status) {
    this.isFlashOn.toggle();
  }

  void initQrData() {
    this.dataNo.value = "-";
    this.dataNama.value = "-";
    this.dataEkspedisi.value = "-";
  }

  void splitResult(String data) {
    if (data != null) {
      var splitted = data.split(" ");
      print("SPLITTED :" + splitted.toString());
      dataNo.value = splitted[0].replaceAll(regexNo, '').toString();
      dataNama.value = splitted[1];
      dataEkspedisi.value = splitted[2].replaceAll(regexBracket, '');
    }
  }

  void saveDataToDB() async {
    this.isDialogLoading.toggle();
    await Future.delayed(Duration(seconds: 1));
    final newData = ScannedData(
      no: dataNo.value,
      nama: dataNama.value,
      ekspedisi: dataEkspedisi.value,
      isSubmitted: 0,
    );
    await dbHelper.saveScannedData(newData);
    this.isDialogLoading.toggle();
    initQrData();
    Get.find<HomeController>().getNotSUbmittedItemLength();
    Get.find<ScannedDataPageController>().getNotSUbmittedItemLength();
  }

  void submitDataToSpreadSheet(String data) async {
    if (dataNo.value != "-" &&
        dataNama.value != "-" &&
        dataEkspedisi.value != "-") {
      this.isSubmitError.value = false;
      await http.get(
        Uri.parse(
            "https://script.google.com/macros/s/AKfycbwuNXlwS0S94C5cDWXjfNHPEpB7xoHI_MRsKIjN-zs8OsDrzRU6xbYifVC6bZsuVs6O/exec?no=${dataNo.value}&nama=${dataNama.value}&ekspedisi=${dataEkspedisi.value}"),
      );
    } else {
      this.isSubmitError.value = true;
    }

    this.isSubmitError.value = false;
    initQrData();
  }
}
