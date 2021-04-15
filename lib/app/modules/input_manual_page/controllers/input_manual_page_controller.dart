import 'package:enviocrsl/app/data/db/database.dart';
import 'package:enviocrsl/app/data/models/ScannedData.dart';
import 'package:enviocrsl/app/modules/scanned_data_page/controllers/scanned_data_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputManualPageController extends GetxController {
  var dbHelper;

  TextEditingController noInputController = TextEditingController();
  TextEditingController namaInputController = TextEditingController();
  TextEditingController ekspedisiInputController = TextEditingController();
  TextEditingController tanggalInputController = TextEditingController();

  var snackBarText = '';

  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    dbHelper = DBHelper();
  }

  saveDataToDb() async {
    this.isLoading.toggle();
    if (noInputController.text != null && noInputController.text != "") {
      if (namaInputController.text != null && namaInputController.text != "") {
        if (ekspedisiInputController.text != null &&
            ekspedisiInputController.text != "") {
          if (tanggalInputController.text != null &&
              tanggalInputController.text != "") {
            // validation success
            var id = DateTime.now().toString();
            await Future.delayed(Duration(seconds: 1));
            final newData = ScannedData(
              id: id,
              no: noInputController.text,
              nama: namaInputController.text,
              ekspedisi: ekspedisiInputController.text,
              tanggal: tanggalInputController.text,
              isSubmitted: 0,
            );

            await dbHelper.saveScannedData(newData);

            snackBarText = "Input data success";
            Get.back();
          } else {
            // if tanggal empty
            snackBarText = "Field 'Tanggal' can't be empty";
          }
        } else {
          // if ekspedisi empty
          snackBarText = "Field 'Ekspedisi' can't be empty";
        }
      } else {
        // if nama empty
        snackBarText = "Field 'Nama' can't be empty";
      }
    } else {
      // if no empty
      snackBarText = "Field 'No' can't be empty";
    }
    await Future.delayed(Duration(seconds: 1));

    this.isLoading.toggle();

    Get.find<ScannedDataPageController>().getNotSUbmittedItemLength();
    Get.find<ScannedDataPageController>().loadScannedData();
    await Future.delayed(Duration(milliseconds: 100));

    Get.snackbar(
      "Status",
      '$snackBarText',
      duration: Duration(seconds: 2),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: Colors.white,
    );
  }
}
