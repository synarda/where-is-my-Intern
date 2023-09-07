import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:whereismyintern/utils/const.dart';

class BlankWdiget extends StatelessWidget {
  const BlankWdiget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            padding: const EdgeInsets.all(8),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colorss.textColor.withOpacity(0.2)),
            child: Lottie.asset("assets/json/blank.json", height: 100, width: 100, fit: BoxFit.cover)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text("there is no convert registered yet.",
              style: Styles.smallTextStyle.copyWith(color: Colors.black.withOpacity(0.5))),
        ),
      ]),
    );
  }
}
