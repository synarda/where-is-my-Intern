import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/controllers/home_controller.dart';
import 'package:whereismyintern/controllers/route_controller.dart';
import 'package:whereismyintern/screens/advertisement.dart';
import 'package:whereismyintern/screens/home_page.dart';
import 'package:whereismyintern/screens/profile_page.dart';
import 'package:whereismyintern/utils/const.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RouteController());

    return GestureDetector(
        child: Scaffold(
            backgroundColor: Colorss.forebackground,
            body: Stack(
              children: [
                PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.controller,
                    onPageChanged: (value) {
                      controller.pageIdx = value;
                      if (value == 0) {
                        Get.find<HomeController>().getData();
                      }
                    },
                    children: const [
                      HomePage(),
                      AdvertisementPage(),
                      ProfilePage(),
                    ]),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CurvedNavigationBar(
                    index: controller.pageIdx,
                    animationDuration: const Duration(milliseconds: 400),
                    height: 60.h,
                    backgroundColor: Colors.transparent,
                    color: Colorss.themeNeon1,
                    buttonBackgroundColor: Colorss.themeNeon1,
                    items: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.home, size: 23, color: Colorss.backgroundColor),
                          Text(
                            "Home",
                            style: Styles.smallTextStyle.copyWith(fontSize: 10, color: Colorss.backgroundColor),
                          )
                        ],
                      ),
                      const Icon(Icons.add, size: 30, color: Colorss.backgroundColor),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.person, size: 23, color: Colorss.backgroundColor),
                          Text(
                            "Profile",
                            style: Styles.smallTextStyle.copyWith(fontSize: 10, color: Colorss.backgroundColor),
                          )
                        ],
                      ),
                    ],
                    onTap: (index) {
                      controller.controller
                          .animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeOutSine);
                    },
                  ),
                ),
              ],
            )));
  }
}
