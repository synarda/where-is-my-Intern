// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/controllers/internship_detail_controller.dart';
import 'package:whereismyintern/models/advertisement_model.dart';
import 'package:whereismyintern/utils/const.dart';
import 'package:whereismyintern/utils/extentions.dart';
import 'package:whereismyintern/widgets/custom_future.dart';

class InternshipDetailPage extends StatelessWidget {
  const InternshipDetailPage({
    Key? key,
    required this.ad,
    required this.pPhoto,
  }) : super(key: key);
  final AdvertisementModel ad;
  final Future<String>? pPhoto;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InternShipDetailController());
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: Get.width,
          width: Get.width,
          padding: EdgeInsets.all(64.sp),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colorss.themeNeon2,
                Colorss.themeNeon3.withOpacity(0.9),
              ],
            ),
          ),
          child: SizedBox(height: 300.h, width: 300.w, child: CustomFutureBuilderWidget(future: pPhoto, size: 50)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Get.height / 1.6,
            width: Get.width,
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
            decoration: const BoxDecoration(
                color: Colorss.backgroundColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(ad.companyName.toUpperCase(),
                      style: Styles.bigTitleStyle.copyWith(fontSize: 25.sp, fontWeight: FontWeight.bold)),
                  SizedBox(width: 24.w),
                  Text(ad.name, style: Styles.bigTitleStyle.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w900)),
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
                          backgroundColor: Colorss.themeNeon2,
                          label: Text("#$e", style: Styles.smallTextStyle.copyWith(color: Colorss.backgroundColor))))
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
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 38.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: Get.back,
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
                            color: Colorss.themeNeon2,
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
    ));
  }
}
