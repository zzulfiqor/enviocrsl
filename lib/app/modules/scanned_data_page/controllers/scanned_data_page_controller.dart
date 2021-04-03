import 'package:enviocrsl/app/data/db/database.dart';
import 'package:enviocrsl/app/data/models/ScannedData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ScannedDataPageController extends GetxController {
  var dbHelper;
  var countNotSubmitted = 0;
  @override
  void onInit() {
    super.onInit();
    this.dbHelper = DBHelper();
    getNotSUbmittedItemLength();
    loadScannedData();
  }

  var dataList = <ScannedData>[].obs;
  // var datalistFiltered = <ScannedData>[].obs;

  void loadScannedData() {
    var notUploadedData = <ScannedData>[];
    Future<List<ScannedData>> dataFromDb = dbHelper.getScannedData();
    dataFromDb.then((value) {
      value.forEach((element) {
        if (element.isSubmitted != 1) {
          notUploadedData.add(element);
        }
      });
      dataList.assignAll(notUploadedData);
      getNotSUbmittedItemLength();
    });
  }

  void updateAllData() async {
    for (final element in dataList) {
      if (element.isSubmitted == 0) {
        element.isSubmitted = 1;
        await http.get(Uri.parse(
            "https://script.google.com/macros/s/AKfycbwuNXlwS0S94C5cDWXjfNHPEpB7xoHI_MRsKIjN-zs8OsDrzRU6xbYifVC6bZsuVs6O/exec?no=${element.no}&nama=${element.nama}&ekspedisi=${element.ekspedisi}"));
        print('data ${element.no} berhasil diupdate');
      } else {
        print('data ${element.no} gagal diupdate');
      }
    }
    dbHelper.updateDataToSubmitted(dataList);
    loadScannedData();
    getNotSUbmittedItemLength();
    Get.snackbar(
      "Status",
      'Success Upload This Data',
      duration: Duration(seconds: 2),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: Colors.white,
    );
  }

  void submitDataToSheet(int i) async {
    if (dataList[i].isSubmitted == 0) {
      dataList[i].isSubmitted = 1;
      await http.get(Uri.parse(
          "https://script.google.com/macros/s/AKfycbwuNXlwS0S94C5cDWXjfNHPEpB7xoHI_MRsKIjN-zs8OsDrzRU6xbYifVC6bZsuVs6O/exec?no=${dataList[i].no}&nama=${dataList[i].nama}&ekspedisi=${dataList[i].ekspedisi}"));
      print('data ${dataList[i].no} berhasil diupdate');
    } else {
      print('data ${dataList[i].no} gagal diupdate');
    }
    dbHelper.updateDataToSubmitted(dataList);
    loadScannedData();
    getNotSUbmittedItemLength();
    Get.snackbar(
      "Status",
      'Success Upload All Data',
      duration: Duration(seconds: 2),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: Colors.white,
    );
  }

  // void deleteSingleData(String id) {
  //   this.dbHelper.deleteDataByNo(id);
  //   loadScannedData();
  // }

  // void deleteAllData() {
  //   this.dbHelper.deleteAllData();
  //   loadScannedData();
  // }

  void getNotSUbmittedItemLength() async {
    var count = await dbHelper.getNoSubmittedDataCount();
    this.countNotSubmitted = count;
    update();
    print("Not Submitted Count : " + count.toString());
  }
}
