import 'dart:convert';

import 'package:enviocrsl/app/data/models/DataSheetModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageController extends GetxController {
  var listData = <DataSheetModel>[];
  var isLoading = false;
  var url =
      'https://script.google.com/macros/s/AKfycbzB6axkdt01xhto3xHw-USFGKcW949cIccQCH9PSQ1BZkh_-2mcf-YzaK2kSOeQJ-807A/exec';

   RefreshController refreshController =
      RefreshController(initialRefresh: false);

  loadDataFromSheet() async {
    this.isLoading = true;
    update();
    var result = await http.get(Uri.parse(url));
    List json = jsonDecode(result.body);
    var listDataFromApi = <DataSheetModel>[];

    json.forEach((element) {
      DataSheetModel data = DataSheetModel();
      data.no = element['no'];
      data.nama = element['nama'];
      data.ekspedisi = element['ekspedisi'];
      listDataFromApi.add(data);
    });
    listData.assignAll(listDataFromApi);
    this.isLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadDataFromSheet();
  }
}
