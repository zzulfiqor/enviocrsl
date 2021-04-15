import 'package:enviocrsl/app/modules/scanned_data_page/controllers/scanned_data_page_controller.dart';
import 'package:enviocrsl/app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteDataDialog extends StatelessWidget {
  const DeleteDataDialog({Key key, this.i}) : super(key: key);

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
                "Delete this data from Sheet ?",
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
                    onPressed: () {
                      Get.find<ScannedDataPageController>().deleteSingleData(i);
                      Get.back();
                      Get.back();
                      Get.snackbar(
                        "Status",
                        'Success Delete Data',
                        duration: Duration(seconds: 2),
                        snackStyle: SnackStyle.GROUNDED,
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.white,
                      );
                    },
                    child: Text(
                      "Delete",
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
