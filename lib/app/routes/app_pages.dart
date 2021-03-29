import 'package:get/get.dart';

import 'package:enviocrsl/app/modules/home/bindings/home_binding.dart';
import 'package:enviocrsl/app/modules/home/views/home_view.dart';
import 'package:enviocrsl/app/modules/home_page/bindings/home_page_binding.dart';
import 'package:enviocrsl/app/modules/home_page/views/home_page_view.dart';
import 'package:enviocrsl/app/modules/scan_qr_page/bindings/scan_qr_page_binding.dart';
import 'package:enviocrsl/app/modules/scan_qr_page/views/scan_qr_page_view.dart';
import 'package:enviocrsl/app/modules/scanned_data_page/bindings/scanned_data_page_binding.dart';
import 'package:enviocrsl/app/modules/scanned_data_page/views/scanned_data_page_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SCANNED_DATA_PAGE,
      page: () => ScannedDataPageView(),
      binding: ScannedDataPageBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_QR_PAGE,
      page: () => ScanQrPageView(),
      binding: ScanQrPageBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => HomePageView(),
      binding: HomePageBinding(),
    ),
  ];
}
