import 'package:enviocrsl/app/utils/app_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/input_manual_page_controller.dart';

class InputManualPageView extends GetView<InputManualPageController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.isLoading.value == true)
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(main_color),
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(
                  'Input Data',
                  style: text_body_regular.copyWith(fontSize: text_size_medium),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: padding_all_body,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textField(
                        title: "No",
                        inputcontroller: controller.noInputController,
                      ),
                      _textField(
                        title: "Nama",
                        inputcontroller: controller.namaInputController,
                      ),
                      _textField(
                        title: "Ekspedisi",
                        inputcontroller: controller.ekspedisiInputController,
                      ),
                      _textField(
                        title: "Tanggal",
                        inputcontroller: controller.tanggalInputController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 55,
                        width: Get.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: main_color_dark),
                          onPressed: () {
                            controller.saveDataToDb();
                          },
                          child: Text(
                            "Input Data",
                            style: text_body_medium,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Container _textField({
    String title,
    TextEditingController inputcontroller,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: text_body_bold,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 1,
                color: main_color_dark,
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 5,
            ),
            child: TextField(
              controller: inputcontroller,
              cursorColor: color_black,
              style: text_body_regular.copyWith(
                fontSize: text_size_medium,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
