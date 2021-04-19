import 'package:enviocrsl/app/modules/scanned_data_page/views/scanned_data_page_view.dart';
import 'package:enviocrsl/app/modules/uploaded_data_list/views/uploaded_data_list_view.dart';
import 'package:enviocrsl/app/utils/app_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/base_controller.dart';

class BaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<BaseController>(
      init: BaseController(),
      builder: (controller) => Scaffold(
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: [
            UploadedDataListView(),
            ScannedDataPageView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: main_color_dark,
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex.value,
          items: [
            buildBottomNavigationBarItem(
                icon: Icons.ballot_outlined, label: "Data"),
            buildBottomNavigationBarItem(
                icon: Icons.qr_code_rounded, label: "Scanned Data"),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      {IconData icon, String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: '$label',
    );
  }
}
