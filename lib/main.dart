import 'package:enviocrsl/app/utils/app_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Envio CRSL",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(primaryColor: main_color_dark, fontFamily: 'Futura'),
    ),
  );
}
