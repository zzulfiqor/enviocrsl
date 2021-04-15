import 'package:enviocrsl/app/modules/scanned_data_page/views/widgets/DeleteDataDIalog.dart';
import 'package:enviocrsl/app/modules/scanned_data_page/views/widgets/SubmitDataDIalog.dart';
import 'package:enviocrsl/app/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../controllers/scanned_data_page_controller.dart';

class ScannedDataPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<ScannedDataPageController>(
      init: ScannedDataPageController(),
      builder: (c) {
        return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              alignment: Alignment.bottomCenter,
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  Align(
                      alignment: Alignment.topRight,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: (c.countNotSubmitted == 0)
                            ? Container(
                                key: Key('kosong'),
                              )
                            : Container(
                                key: Key('isi'),
                                padding: EdgeInsets.only(right: 15),
                                child: FloatingActionButton(
                                    backgroundColor: accent_color_dark,
                                    child: Icon(CupertinoIcons.cloud_upload),
                                    onPressed: () async {
                                      c.getNotSUbmittedItemLength();
                                      // ignore: await_only_futures
                                      await c.updateAllData();
                                      Get.snackbar(
                                        "Status",
                                        'Success Upload all Data',
                                        duration: Duration(seconds: 2),
                                        snackStyle: SnackStyle.GROUNDED,
                                        backgroundColor: Colors.white,
                                      );
                                    }),
                              ),
                      )),
                  //
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    height: 100,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: Get.width * .43,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: main_color_dark,
                            ),
                            onPressed: () {
                              Get.toNamed('/scan-qr-page');
                            },
                            icon: Icon(
                              CupertinoIcons.qrcode_viewfinder,
                              color: color_black,
                            ),
                            label: Text(
                              "Scan Qr Code",
                              style: text_body_medium,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: Get.width * .43,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: main_color_dark,
                            ),
                            onPressed: () {
                              Get.toNamed('/input-manual-page');
                            },
                            icon: Icon(
                              Icons.list_alt,
                              color: color_black,
                            ),
                            label: Text(
                              "Manual Input",
                              style: text_body_medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              backgroundColor: main_color_dark,
              title: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "EnvioCRSL Data",
                  style: text_body_medium.copyWith(
                      fontSize: text_size_medium, color: color_black),
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 105),
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : (c.isUploading.value == true)
                      ? Container(
                          height: Get.height * .75,
                          width: Get.width,
                          child: Center(
                            child: Transform.scale(
                                scale: .4,
                                child: LottieBuilder.asset(
                                    'assets/lotties/uploading_animation.json')),
                          ),
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
                                    return _itemScanned(c, i, context);
                                  }),
                            ],
                          ),
                        ),
            ));
      },
    );
  }

  Widget _itemScanned(
      ScannedDataPageController c, int i, BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            child: InkWell(
              onTap: () {
                return showMaterialModalBottomSheet(
                  expand: false,
                  context: context,
                  builder: (context) => Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                            title: Text("Update"),
                            leading: Icon(CupertinoIcons.cloud_upload),
                            onTap: () async {
                              Get.dialog(
                                SubmitDataDialog(
                                  i: i,
                                ),
                              );
                            }),
                        ListTile(
                            title: Text("Delete"),
                            leading: Icon(CupertinoIcons.trash),
                            onTap: () => Get.dialog(DeleteDataDialog(
                                  i: i,
                                ))),
                      ],
                    ),
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
                        width: 30,
                        child: Icon(
                          Icons.qr_code_scanner,
                          size: 28,
                          color: main_color_dark,
                        )),
                    Expanded(
                        child: Container(
                      height: 55,
                      padding: EdgeInsets.only(left: 15, right: 20),
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
                                'Tanggal :',
                                style: text_body_regular.copyWith(
                                  fontSize: text_size_smallest,
                                  color: color_grey_dark,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${c.dataList[i].tanggal}',
                                style: text_body_medium.copyWith(
                                    fontSize: text_size_regular),
                              ),
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
