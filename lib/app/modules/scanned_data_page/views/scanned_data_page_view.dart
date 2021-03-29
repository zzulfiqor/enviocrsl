import 'package:enviocrsl/app/modules/home/controllers/home_controller.dart';
import 'package:enviocrsl/app/modules/scan_qr_page/controllers/scan_qr_page_controller.dart';
import 'package:enviocrsl/app/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/scanned_data_page_controller.dart';

class ScannedDataPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<ScannedDataPageController>(
      init: ScannedDataPageController(),
      builder: (c) {
        return Scaffold(
            floatingActionButton: (c.countNotSubmitted == 0)
                ? null
                : FloatingActionButton(
                    backgroundColor: accent_color_dark,
                    child: Icon(Icons.upload_file),
                    onPressed: (c.dataList.length == 0)
                        ? null
                        : () {
                            c.updateAllData();
                            c.getNotSUbmittedItemLength();
                          },
                  ),
            appBar: AppBar(
              backgroundColor: main_color_dark,
              title: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Scanned Data",
                  style: text_body_medium.copyWith(
                      fontSize: text_size_medium, color: color_black),
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: (c.dataList.length == 0)
                  ? Stack(
                      children: [
                        Container(
                          height: Get.height * .75,
                          width: Get.width,
                          child: Center(
                            child: Transform.scale(
                                scale: .5,
                                child: LottieBuilder.asset(
                                    'assets/lotties/empty_animation.json')),
                          ),
                        ),
                        Positioned(
                          top: Get.height * .45,
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: Get.width,
                            child: Column(
                              children: [
                                Text(
                                  "Data Empty.",
                                  style: text_body_medium.copyWith(
                                    color: color_grey_dark,
                                    fontSize: text_size_small,
                                  ),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: main_color_dark,
                                    ),
                                    onPressed: () {
                                      Get.find<ScanQrPageController>()
                                          .isTabOpen
                                          .value = true;

                                      Get.find<HomeController>()
                                          .changeTabIndex(1);
                                    },
                                    child: Text(
                                      "Scan Data",
                                      style: text_body_regular.copyWith(
                                        fontSize: text_size_small,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      padding: EdgeInsets.all(padding_body_size),
                      width: Get.width,
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: c.dataList.length,
                              itemBuilder: (_, i) {
                                return _itemScanned(c, i);
                              }),
                        ],
                      ),
                    ),
            ));
      },
    );
  }

  Widget _itemScanned(ScannedDataPageController c, int i) {
    return Column(
      children: [
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            child: InkWell(
              onTap: () {
                return Get.dialog(
                  _SubmitDataDialog(
                    i: i,
                  ),
                );
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(padding_body_size),
                width: Get.width,
                child: Row(
                  children: [
                    // Icon
                    Ink(
                        height: 55,
                        width: 45,
                        child: Icon(
                          Icons.qr_code_scanner,
                          size: 32,
                          color: main_color_dark,
                        )),
                    Expanded(
                        child: Container(
                      height: 55,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No : ${c.dataList[i].no}',
                                style: text_body_regular.copyWith(
                                  fontSize: text_size_smallest,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${c.dataList[i].nama}',
                                style: text_body_medium.copyWith(
                                    fontSize: text_size_regular),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ekspedisi :',
                                style: text_body_regular.copyWith(
                                  fontSize: text_size_smallest,
                                  color: color_grey_dark,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${c.dataList[i].ekspedisi}',
                                style: text_body_medium.copyWith(
                                    fontSize: text_size_regular),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status :',
                                style: text_body_regular.copyWith(
                                  fontSize: text_size_smallest,
                                  color: color_grey_dark,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Ink(
                                child: Row(
                                  children: [
                                    Ink(
                                        decoration: BoxDecoration(
                                            color:
                                                (c.dataList[i].isSubmitted == 1)
                                                    ? Colors.green
                                                    : accent_color_dark,
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        height: 10,
                                        width: 10),
                                    SizedBox(width: 5),
                                    Text(
                                        (c.dataList[i].isSubmitted == 1)
                                            ? "Uploaded"
                                            : "Not Uploaded",
                                        style: text_body_regular.copyWith(
                                            fontSize: text_size_smallest)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                    Ink(
                        height: 55,
                        width: 30,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmitDataDialog extends StatelessWidget {
  const _SubmitDataDialog({Key key, this.i}) : super(key: key);

  final int i;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.center,
      child:
          (Get.find<ScannedDataPageController>().dataList[i].isSubmitted == 1)
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: Get.width * .65,
                  child: Material(
                    color: Colors.white,
                    child: Text(
                      "Data has been submitted",
                      style: text_body_medium,
                    ),
                  ),
                )
              : Container(
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
                          "Submit data Sheet ?",
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
                              onPressed: (Get.find<ScannedDataPageController>()
                                          .dataList[i]
                                          .isSubmitted ==
                                      1)
                                  ? null
                                  : () {
                                      Get.find<ScannedDataPageController>()
                                          .submitDataToSheet(i);
                                    },
                              child: Text(
                                "Submit",
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
