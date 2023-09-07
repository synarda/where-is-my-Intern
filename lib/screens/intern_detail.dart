// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:whereismyintern/controllers/intern_detail_controller.dart';
import 'package:whereismyintern/models/advertisement_model.dart';
import 'package:whereismyintern/utils/const.dart';
import 'package:whereismyintern/utils/extentions.dart';
import 'package:whereismyintern/widgets/custom_future.dart';

class InternDetailPage extends StatelessWidget {
  const InternDetailPage({
    Key? key,
    required this.qrCode,
    required this.ad,
    required this.pPhoto,
  }) : super(key: key);
  final String qrCode;
  final AdvertisementModel ad;
  final Future<String>? pPhoto;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InternDetailController());
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        controller.sliderPosition.value = 1;
        return true;
      },
      child: Scaffold(
          body: Stack(
        children: [
          Obx(() => Container(
                height: Get.height / (controller.sliderPosition.value * 2),
                width: Get.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colorss.themeNeon1.withOpacity(0.7),
                      Colorss.themeNeon4.withOpacity(0.9),
                    ],
                  ),
                ),
                child: Hero(
                  tag: ad.uid,
                  child: QrImageView(
                    data: qrCode,
                    version: QrVersions.auto,
                    size: controller.sliderPosition.value <= 0.5 ? 500 : 200,
                  ),
                ),
              )),
          SlidingUpPanel(
            onPanelSlide: (position) {
              controller.sliderPosition.value = position;
            },
            defaultPanelState: PanelState.OPEN,
            controller: controller.panelController,
            maxHeight: Get.height / 1.6,
            minHeight: 200.h,
            padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: const Radius.circular(20)),
            panel: Column(children: [
              Divider(
                  color: Colors.grey, endIndent: Get.width / 2.7, height: 10.h, indent: Get.width / 2.7, thickness: 3),
              Row(
                children: [
                  CustomFutureBuilderWidget(future: pPhoto, size: 100),
                  SizedBox(width: 16.w),
                  Text(ad.name.toUpperCase(),
                      style: Styles.bigTitleStyle.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w900)),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                ad.description,
                style: Styles.mediumTextStyle.copyWith(color: Colorss.forebackground.withOpacity(0.5)),
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 10,
                  children: ad.skills
                      .map((e) => Chip(
                          backgroundColor: Colorss.themeNeon1,
                          label: Text("#$e", style: Styles.smallTextStyle.copyWith(color: Colors.white))))
                      .toList(),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ad.email,
                    style: Styles.smallTextStyle.copyWith(color: Colorss.forebackground.withOpacity(0.5)),
                  ),
                  Text(
                    Parsers.dateTo(DateTime.parse(ad.createdAt)),
                    style: Styles.smallTextStyle.copyWith(color: Colorss.forebackground.withOpacity(0.5)),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ]),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 38.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        controller.sliderPosition.value = 1;
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colorss.backgroundColor,
                      ),
                    ),
                    ad.email == controller.userInfo.currentUser!.email
                        ? IconButton(
                            onPressed: controller.delete,
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colorss.themeNeon1,
                            ),
                          )
                        : const SizedBox(
                            height: 20,
                            width: 20,
                          ),
                  ],
                ),
              )),
        ],
      )),
    );
  }
}
