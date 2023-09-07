// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/utils/const.dart';
import 'package:whereismyintern/utils/helper.dart';

class AdvertisementWidget extends StatelessWidget {
  const AdvertisementWidget({
    Key? key,
    required this.txt,
    required this.function,
    required this.lottie,
    required this.color,
  }) : super(key: key);
  final String txt;
  final Function() function;
  final String lottie;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        height: 400.h,
        margin: const EdgeInsets.all(16),
        width: Get.width,
        decoration: BoxDecoration(boxShadow: [Helper.boxShadow], borderRadius: BorderRadius.circular(20), color: color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colorss.backgroundColor.withOpacity(0.2)),
              child: const Icon(
                Icons.add,
                color: Colorss.backgroundColor,
                size: 80,
              ),
            ),
            Center(
                child: Text(txt,
                    textAlign: TextAlign.center, style: Styles.bigTitleStyle.copyWith(color: Colorss.backgroundColor)))
          ],
        ),
      ),
    );
  }
}
