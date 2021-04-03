import 'package:enviocrsl/app/data/db/database.dart';
import 'package:enviocrsl/app/data/models/ScannedData.dart';
import 'package:enviocrsl/app/modules/scanned_data_page/controllers/scanned_data_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPageController extends GetxController {
  QRViewController qrViewController;
  var dbHelper;

  @override
  void onInit() {
    super.onInit();
    this.dbHelper = DBHelper();
  }

  @override
  void onClose() {
    super.onClose();
    Get.put(ScannedDataPageController()).loadScannedData();
  }

  var isDataHaveSaved = false.obs;
  var isTabOpen = true.obs;
  var isSubmitError = false.obs;
  var isFlashOn = false.obs;
  var isDialogLoading = false.obs;

  var dataFromQr = "";
  var snackBarText = "".obs;
  var dataNo = '-'.obs;
  var dataNama = '-'.obs;
  var dataEkspedisi = '-'.obs;

  var regexNo = RegExp(r'[^0-9]+');
  var regexBracket = RegExp(r'\[|\]');

  void setDataFromQr(String data) {
    this.dataFromQr = data.trim();
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

    isDataHaveSavedToDB(newData);

    await Future.delayed(Duration(seconds: 1));

    if (isDataHaveSaved.value == true) {
      this.snackBarText.value = "This data has been submitted before";
    } else if (isDataHaveSaved.value == false) {
      if (newData.ekspedisi == "-" ||
          newData.no == "-" ||
          newData.nama == "-") {
        this.snackBarText.value = "Data format Error";
      } else {
        this.snackBarText.value = "Data submit success";

        await dbHelper.saveScannedData(newData);
      }
    }

    Get.snackbar(
      "Status",
      '${Get.find<ScanQrPageController>().snackBarText.value}',
      duration: Duration(seconds: 2),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: Colors.white,
    );

    this.isDataHaveSaved.value = false;

    this.isDialogLoading.toggle();

    initQrData();

    Get.find<ScannedDataPageController>().getNotSUbmittedItemLength();
    Get.find<ScannedDataPageController>().loadScannedData();
  }

  Future<void> isDataHaveSavedToDB(ScannedData scannedData) async {
    var state = false;
    List<ScannedData> dataFromDb = await dbHelper.getScannedData();
    dataFromDb.forEach((element) {
      if (scannedData.no == element.no) {
        print("isDataHaveSavedToDb = ${element.no} sudah ada di database");
        state = true;
        print("state true = $state");
      } else {}
    });
    this.isDataHaveSaved.value = state;
    print(state.toString());
  }
}
