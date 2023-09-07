// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/utils/const.dart';

class ModuleTitleWidget extends StatelessWidget {
  const ModuleTitleWidget({
    Key? key,
    required this.txt01,
    this.txt02 = "",
    this.color = Colorss.themeNeon1,
  }) : super(key: key);
  final String txt01;
  final String txt02;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: Get.back,
              icon: Icon(
                Icons.arrow_back_ios,
                color: color,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Text(txt01, style: Styles.smallTitleStyle.copyWith(color: color, fontWeight: FontWeight.w900)),
                txt02.isEmpty
                    ? const SizedBox()
                    : Text(txt02, style: Styles.smallTitleStyle.copyWith(color: color, fontWeight: FontWeight.w900)),
              ],
            ),
            const Spacer()
          ],
        ),
        Divider(
          color: color,
        )
      ],
    );
  }
}
