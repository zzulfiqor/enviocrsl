import 'package:enviocrsl/app/modules/scanned_data_page/controllers/scanned_data_page_controller.dart';
import 'package:enviocrsl/app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitDataDialog extends StatelessWidget {
  const SubmitDataDialog({Key key, this.i}) : super(key: key);

  final int i;
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
                "Submit this data to Sheet ?",
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
                      style: text_body_bold.copyWith(color: main_color_dark),
                    ),
                  )),
                  SizedBox(width: 15),
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: main_color_dark),
                    onPressed: (Get.find<ScannedDataPageController>()
                                .dataList[i]
                                .isSubmitted ==
                            1)
                        ? null
                        : () async {
                            Get.back();
                            Get.back();
                            // ignore: await_only_futures
                            await Get.find<ScannedDataPageController>()
                                .submitDataToSheet(i);
                            Get.snackbar(
                              "Status",
                              'Success Upload Data',
                              duration: Duration(seconds: 2),
                              snackStyle: SnackStyle.GROUNDED,
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.white,
                            );
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
