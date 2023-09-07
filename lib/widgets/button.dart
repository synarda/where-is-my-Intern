// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/utils/const.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.bgColor,
    required this.function,
    required this.txt,
    required this.txtColor,
    this.padding = 24,
  }) : super(key: key);
  final Color bgColor;
  final Function() function;
  final String txt;
  final Color txtColor;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: GestureDetector(
        onTap: () => function(),
        child: Container(
            height: 60.h,
            width: Get.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                txt,
                textAlign: TextAlign.center,
                style: Styles.smallTextStyle.copyWith(color: txtColor),
              ),
            )),
      ),
    );
  }
}
