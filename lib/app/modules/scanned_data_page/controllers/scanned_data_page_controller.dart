import 'dart:convert';

import 'package:enviocrsl/app/data/db/database.dart';
import 'package:enviocrsl/app/data/models/ScannedData.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ScannedDataPageController extends GetxController {
  var dbHelper;
  var countNotSubmitted = 0;

  //
  var isUploading = false.obs;

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
    this.isUploading.toggle();
    for (final element in dataList) {
      if (element.isSubmitted == 0) {
        element.isSubmitted = 1;
        var response = await http.get(Uri.parse(
            "https://script.google.com/macros/s/AKfycbwuNXlwS0S94C5cDWXjfNHPEpB7xoHI_MRsKIjN-zs8OsDrzRU6xbYifVC6bZsuVs6O/exec?no=${element.no}&nama=${element.nama}&ekspedisi=${element.ekspedisi}&tanggal=${element.tanggal}"));
        var status = jsonDecode(response.body)['status'];
        if (status == "SUCCESS") {
          print('data ${element.no} berhasil diupdate');
        } else {
          print('data ${element.no} gagal diupdate');
        }
      } else {
        print('data ${element.no} gagal diupdate');
      }
    }
    dbHelper.updateDataToSubmitted(dataList);
    loadScannedData();
    getNotSUbmittedItemLength();
    this.isUploading.toggle();
  }

  void submitDataToSheet(int i) async {
    this.isUploading.toggle();
    dataList[i].isSubmitted = 1;
    var response = await http.get(Uri.parse(
        "https://script.google.com/macros/s/AKfycbwuNXlwS0S94C5cDWXjfNHPEpB7xoHI_MRsKIjN-zs8OsDrzRU6xbYifVC6bZsuVs6O/exec?no=${dataList[i].no}&nama=${dataList[i].nama}&ekspedisi=${dataList[i].ekspedisi}&tanggal=${dataList[i].tanggal}"));
    var status = jsonDecode(response.body)['status'];

    if (status == 'SUCCESS') {
      dbHelper.updateDataToSubmitted(dataList);
      loadScannedData();
      this.isUploading.toggle();
    } else {
      this.isUploading.toggle();
    }
  }

  void deleteSingleData(int i) {
    var id = dataList[i].id;
    this.dbHelper.deleteDataByNo(id);
    loadScannedData();
    getNotSUbmittedItemLength();
  }

  void getNotSUbmittedItemLength() async {
    var count = await dbHelper.getNoSubmittedDataCount();
    this.countNotSubmitted = count;
    update();
    print("Not Submitted Count : " + count.toString());
  }
}
