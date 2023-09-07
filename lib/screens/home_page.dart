import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/controllers/home_controller.dart';
import 'package:whereismyintern/controllers/profile_controller.dart';
import 'package:whereismyintern/models/advertisement_model.dart';
import 'package:whereismyintern/utils/helper.dart';
import 'package:whereismyintern/widgets/advertisement_list_item.dart';
import 'package:whereismyintern/widgets/animated_Listview.dart';
import 'package:whereismyintern/widgets/blank.dart';

import '../utils/const.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final controllerProfile = Get.find<ProfileController>();

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: Helper.mainLinearGradient),
      child: Padding(
        padding: EdgeInsets.only(top: 64.h),
        child: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                labelStyle: Styles.smallTextStyle
                    .copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colorss.backgroundColor),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colorss.themeNeon1,
                ),
                enableFeedback: true,
                labelColor: Colorss.backgroundColor,
                unselectedLabelColor: Colorss.backgroundColor.withOpacity(0.4),
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "Intern"),
                  Tab(text: "Internship"),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  Obx(() => controller.dataList.isNotEmpty
                      ? AnimatedListView(
                          padding: EdgeInsets.zero,
                          reverse: false,
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          children: controller.dataList
                              .map((e) => AdvertisementListItemWidget(
                                    ad: AdvertisementModel(
                                        createdAt: e.createdAt,
                                        description: e.description,
                                        email: e.email,
                                        name: e.name,
                                        skills: e.skills,
                                        status: e.status,
                                        companyName: e.companyName,
                                        uid: e.uid),
                                    key: ValueKey(e.uid),
                                    pPhoto: controllerProfile.storage.downloadURL(e.email),
                                  ))
                              .toList(),
                        )
                      : const BlankWdiget()),
                  Obx(() => controller.dataList.where((p1) => "intern" == p1.status).isNotEmpty
                      ? AnimatedListView(
                          padding: EdgeInsets.zero,
                          reverse: false,
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          children: controller.dataList
                              .where((p1) => "intern" == p1.status)
                              .map((e) => AdvertisementListItemWidget(
                                    ad: AdvertisementModel(
                                        createdAt: e.createdAt,
                                        description: e.description,
                                        email: e.email,
                                        name: e.name,
                                        skills: e.skills,
                                        companyName: e.companyName,
                                        status: e.status,
                                        uid: e.uid),
                                    key: ValueKey(e.uid),
                                    pPhoto: controllerProfile.storage.downloadURL(e.email),
                                  ))
                              .toList(),
                        )
                      : const BlankWdiget()),
                  Obx(() => controller.dataList.where((p1) => "internShip" == p1.status).isNotEmpty
                      ? AnimatedListView(
                          padding: EdgeInsets.zero,
                          reverse: false,
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          children: controller.dataList
                              .where((p1) => "internShip" == p1.status)
                              .map((e) => AdvertisementListItemWidget(
                                    ad: AdvertisementModel(
                                        description: e.description,
                                        uid: e.uid,
                                        name: e.name,
                                        status: e.status,
                                        companyName: e.companyName,
                                        email: e.email,
                                        skills: e.skills,
                                        createdAt: e.createdAt),
                                    key: ValueKey(e.uid),
                                    pPhoto: controllerProfile.storage.downloadURL(e.email),
                                  ))
                              .toList(),
                        )
                      : const BlankWdiget()),
                ]),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
