import 'package:enviocrsl/app/utils/app_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/uploaded_data_list_controller.dart';

class UploadedDataListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadedDataListController>(
      init: UploadedDataListController(),
      builder: (c) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: main_color_dark,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Uploaded Data",
                    style: text_body_medium.copyWith(
                        fontSize: text_size_medium, color: color_black),
                  ),
                ],
              ),
            ),
            body: SmartRefresher(
              enablePullDown: true,
              controller: c.refreshController,
              onRefresh: () async {
                c.loadDataFromSheet();
                c.refreshController.refreshCompleted();
              },
              onLoading: () async {
                c.refreshController.loadComplete();
              },
              header: MaterialClassicHeader(),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: (c.isLoading)
                    ? _LoadingAnimationSection()
                    : Container(
                        padding: padding_all_body,
                        width: Get.width,
                        child: (c.listData.length == 0)
                            ? _EmptyAnimationSection()
                            : _ListDataSection()),
              ),
            ));
      },
    );
  }
}

class _ListDataSection extends StatelessWidget {
  const _ListDataSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadedDataListController>(
      builder: (c) {
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: c.listData.length,
            itemBuilder: (_, i) {
              return _listItem(c, i);
            });
      },
    );
  }

  Widget _listItem(UploadedDataListController c, int i) {
    return Column(
      children: [
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No : ${c.listData[i].no}',
                            style: text_body_regular.copyWith(
                              fontSize: text_size_smallest,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${c.listData[i].nama}',
                            style: text_body_medium.copyWith(
                                fontSize: text_size_regular),
                          ),
                        ],
                      ),
                      SizedBox(width: 40),
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
                            '${c.listData[i].ekspedisi}',
                            style: text_body_medium.copyWith(
                                fontSize: text_size_regular),
                          ),
                        ],
                      ),
                      SizedBox(width: 40),
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
                            '${c.listData[i].tanggal}',
                            style: text_body_medium.copyWith(
                                fontSize: text_size_regular),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                Ink(
                  decoration: BoxDecoration(
                    color: main_color_dark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 55,
                  width: 5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyAnimationSection extends StatelessWidget {
  const _EmptyAnimationSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height * .75,
          width: Get.width,
          child: Center(
            child: Transform.scale(
                scale: .5,
                child:
                    LottieBuilder.asset('assets/lotties/empty_animation.json')),
          ),
        ),
        Positioned(
          top: Get.height * .45,
          child: Container(
            alignment: Alignment.center,
            height: 80,
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
                Text(
                  "Pull down the page to refresh the page.",
                  style: text_body_medium.copyWith(
                    color: color_grey_dark,
                    fontSize: text_size_small,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _LoadingAnimationSection extends StatelessWidget {
  const _LoadingAnimationSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding_all_body,
      height: Get.height * .75,
      width: Get.width,
      child: Center(
        child: Transform.scale(
            scale: .5,
            child:
                LottieBuilder.asset('assets/lotties/loading_animation.json')),
      ),
    );
  }
}
