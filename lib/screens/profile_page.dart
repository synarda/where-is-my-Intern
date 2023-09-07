import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/controllers/auth_controller.dart';
import 'package:whereismyintern/controllers/profile_controller.dart';
import 'package:whereismyintern/utils/const.dart';
import 'package:whereismyintern/widgets/profile_buttons.dart';
import 'package:whereismyintern/widgets/profile_photo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerAuth = Get.find<AuthController>();
    final controllerProfile = Get.find<ProfileController>();

    return Obx(() => Scaffold(
          body: AnimatedContainer(
            duration: 500.ms,
            color: Colorss.themeNeon1,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: Get.height / 1.4,
                    decoration: BoxDecoration(
                        color: Colorss.backgroundColor,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
                    child: Column(
                      children: [
                        SizedBox(height: 100.h),
                        ProfileButtonsWidget(
                            function: controllerProfile.addPhoto,
                            txt: "Add Photo",
                            iconLeft: Icons.photo,
                            isNegative: false,
                            delay: 0),
                        ProfileButtonsWidget(
                            function: () => controllerAuth.signOut(),
                            txt: "Log Out",
                            iconLeft: Icons.logout,
                            isNegative: true,
                            delay: 200),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: Get.height / 1.6,
                  left: (Get.width / 4).sp,
                  child: Column(
                    children: [
                      Text(
                        controllerAuth.user.value?.displayName!.toUpperCase() ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: Styles.bigTitleStyle.copyWith(fontSize: 18, color: Colorss.backgroundColor),
                      ),
                      ProfilePhotoWidget(
                        borderColor: Colorss.themeNeon1,
                        iconSize: 90.sp,
                        borderSize: 10.sp,
                        size: 200.sp,
                        future:
                            controllerProfile.storage.downloadURL(controllerAuth.user.value?.email.toString() ?? ""),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
