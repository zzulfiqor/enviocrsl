import 'package:enviocrsl/app/utils/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controllers/scan_qr_page_controller.dart';

class ScanQrPageView extends GetView<ScanQrPageController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
      },
      child: GetX<ScanQrPageController>(
        init: ScanQrPageController(),
        builder: (c) {
          return Scaffold(
            body: (c.isTabOpen.value)
                ? SafeArea(
                    child: Stack(
                      children: [
                        // Scan Camera View
                        QRView(
                            key: GlobalKey(debugLabel: 'QR'),
                            onQRViewCreated: (scanController) {
                              c.qrViewController = scanController;
                              scanController.scannedDataStream.listen((val) {
                                scanController.pauseCamera();
                                c.splitResult(val.code);
                                Get.dialog(
                                  (c.isDialogLoading.value == false)
                                      ? _DialogSubmitData()
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                  barrierDismissible: false,
                                );
                              });
                            }),
                        // Scan Animation
                        Positioned.fill(
                          child: Opacity(
                            opacity: .4,
                            child: LottieBuilder.asset(
                                'assets/lotties/scan_animation.json'),
                          ),
                        ),
                        // Flash
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GetX<ScanQrPageController>(
                              init: ScanQrPageController(),
                              initState: (_) {},
                              builder: (_) {
                                return IconButton(
                                  icon: Icon(
                                    (_.isFlashOn.value)
                                        ? Icons.flash_off
                                        : Icons.flash_on,
                                    size: 32,
                                    color: Colors.amber,
                                  ),
                                  onPressed: () {
                                    c.qrViewController.toggleFlash();
                                    c.qrViewController.getFlashStatus().then(
                                          (value) => c.toggleFlashStatus(value),
                                        );
                                  },
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  )
                : Container(),
          );
        },
      ),
    );
  }
}

class _DialogSubmitData extends StatelessWidget {
  const _DialogSubmitData({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          height: Get.height * .25,
          width: Get.width * .75,
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Text(
                  "Submit This Data ?",
                  style: text_body_bold,
                ),
                // Data
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Index Data
                      Container(
                        color: Colors.white,
                        width: Get.width * .15,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "No.",
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${Get.find<ScanQrPageController>().dataNo.value}",
                              style: text_body_medium,
                            ),
                          ],
                        ),
                      ),
                      // Index Nama
                      Container(
                        color: Colors.white,
                        width: Get.width * .25,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Nama",
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${Get.find<ScanQrPageController>().dataNama.value}",
                              style: text_body_medium,
                            ),
                          ],
                        ),
                      ),
                      // Index Ekspedisi
                      Container(
                        color: Colors.white,
                        width: Get.width * .2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Ekspedisi",
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${Get.find<ScanQrPageController>().dataEkspedisi.value}",
                              style: text_body_medium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                        Get.find<ScanQrPageController>()
                            .qrViewController
                            .resumeCamera();
                      },
                      child: Text(
                        "Cancel",
                        style:
                            text_body_medium.copyWith(color: main_color_dark),
                      ),
                    )),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: main_color_dark),
                      onPressed: () async {
                        Get.find<ScanQrPageController>().saveDataToDB();
                        Get.find<ScanQrPageController>()
                            .qrViewController
                            .resumeCamera();
                        Get.back();
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
      ),
    );
  }
}
