import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/screens/create_internship.dart';
import 'package:whereismyintern/utils/const.dart';
import 'package:whereismyintern/utils/helper.dart';
import 'package:whereismyintern/widgets/advertisement.dart';

class AdvertisementPage extends StatelessWidget {
  const AdvertisementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.backgroundColor,
      body: Container(
        decoration: BoxDecoration(gradient: Helper.mainLinearGradient),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          AdvertisementWidget(
            color: Colorss.themeNeon1,
            function: () => Get.bottomSheet(
                ignoreSafeArea: false,
                clipBehavior: Clip.hardEdge,
                isScrollControlled: true,
                const CreateInternshipPage(isIntern: true)),
            txt: "Advertise to find an internship",
            lottie: "number01",
          ),
          AdvertisementWidget(
            color: Colorss.themeNeon2,
            function: () => Get.bottomSheet(
                ignoreSafeArea: false,
                clipBehavior: Clip.hardEdge,
                isScrollControlled: true,
                const CreateInternshipPage(isIntern: false)),
            txt: "I'm looking for an intern.",
            lottie: "number02",
          ),
        ]),
      ),
    );
  }
}
