import 'dart:io';

import 'package:enviocrsl/app/modules/home_page/views/home_page_view.dart';
import 'package:enviocrsl/app/modules/scan_qr_page/controllers/scan_qr_page_controller.dart';
import 'package:enviocrsl/app/modules/scan_qr_page/views/scan_qr_page_view.dart';
import 'package:enviocrsl/app/modules/scanned_data_page/views/scanned_data_page_view.dart';
import 'package:enviocrsl/app/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Get.dialog(
          _CloseAppDialog(),
        );
      },
      child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (c) {
            return Scaffold(
              body: SafeArea(
                  child: IndexedStack(
                index: c.tabIndex,
                children: [
                  HomePageView(),
                  ScanQrPageView(),
                  ScannedDataPageView(),
                ],
              )),
              bottomNavigationBar: BottomNavigationBar(
                onTap: c.changeTabIndex,
                currentIndex: c.tabIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.list_bullet,
                      color: Colors.white,
                    ),
                    label: 'Scan QR',
                  ),
                  BottomNavigationBarItem(
                    icon: (c.countNotSubmitted != 0)
                        ? Badge(
                            badgeColor: accent_color_dark,
                            shape: BadgeShape.circle,
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(CupertinoIcons.list_dash),
                            badgeContent: Container(
                              height: 1,
                              width: 1,
                            ),
                          )
                        : Icon(CupertinoIcons.list_dash),
                    label: 'Scanned Data',
                  ),
                ],
              ),
              floatingActionButton: SizedBox(
                height: 50,
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: main_color_dark,
                  ),
                  child: Icon(
                    CupertinoIcons.qrcode_viewfinder,
                    color: color_black,
                  ),
                  onPressed: () {
                    Get.find<ScanQrPageController>().isTabOpen.toggle();
                    c.changeTabIndex(1);
                  },
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          }),
    );
  }
}

class _CloseAppDialog extends StatelessWidget {
  const _CloseAppDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.center,
      child: Container(
        padding: padding_all_body,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        height: Get.height * .15,
        width: Get.width * .65,
        child: Material(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Text(
                "Close Envio CRSL App ?",
                style: text_body_bold,
              ),
              // Spacer
              SizedBox(
                height: 15,
              ),
              // Row of Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Cancel",
                      style: text_body_medium.copyWith(
                          color: main_color_dark),
                    ),
                  )),
                  SizedBox(width: 15),
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: main_color_dark),
                    onPressed: () {
                      exit(0);
                    },
                    child: Text(
                      "Exit",
                      style: text_body_medium,
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
