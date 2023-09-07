// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/controllers/advertisement_controller.dart';
import 'package:whereismyintern/controllers/auth_controller.dart';
import 'package:whereismyintern/controllers/profile_controller.dart';
import 'package:whereismyintern/utils/const.dart';
import 'package:whereismyintern/utils/helper.dart';
import 'package:whereismyintern/widgets/button.dart';
import 'package:whereismyintern/widgets/module_title.dart';
import 'package:whereismyintern/widgets/profile_photo.dart';
import 'package:whereismyintern/widgets/textfield.dart';

class CreateInternshipPage extends StatelessWidget {
  const CreateInternshipPage({
    Key? key,
    required this.isIntern,
  }) : super(key: key);
  final bool isIntern;
  @override
  Widget build(BuildContext context) {
    final controllerAuth = Get.find<AuthController>();
    final controllerProfile = Get.find<ProfileController>();

    final controller = Get.put(AdvertisementController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: Get.height / 1.8,
        width: Get.width,
        decoration: const BoxDecoration(
            color: Colorss.backgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Stack(
          children: [
            ListView(children: [
              ModuleTitleWidget(
                color: isIntern ? Colorss.themeNeon1 : Colorss.themeNeon2,
                txt01: isIntern ? "Intern advertisement" : "Internship advertisement.",
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ProfilePhotoWidget(
                              borderColor: Colorss.themeNeon1,
                              iconSize: 30.sp,
                              borderSize: 2.sp,
                              size: 50.sp,
                              future: controllerProfile.storage
                                  .downloadURL(controllerAuth.user.value?.email.toString() ?? ""),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              controllerAuth.user.value?.displayName!.toUpperCase() ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: Styles.smallTextStyle.copyWith(color: Colorss.forebackground),
                            ),
                            const Spacer(),
                            isIntern
                                ? FutureBuilder(
                                    future: controllerProfile.storage
                                        .downloadURLCV(controllerAuth.user.value?.email.toString() ?? ""),
                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                        controller.checkCv.value = snapshot.hasData;
                                        controller.cvLink.value = snapshot.data.toString();
                                        return GestureDetector(
                                          onTap: controller.addCV,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              "Add CV",
                                              textAlign: TextAlign.start,
                                              style: Styles.mediumTextStyle.copyWith(color: Colorss.themeNeon1),
                                            ),
                                          ),
                                        );
                                      }

                                      return GestureDetector(
                                        onTap: controller.addCV,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            "Add Cv",
                                            textAlign: TextAlign.start,
                                            style: Styles.mediumTextStyle.copyWith(color: Colorss.themeNeon1),
                                          ),
                                        ),
                                      );
                                    })
                                : const SizedBox()
                          ],
                        ),
                        !isIntern
                            ? Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  TextfieldWidget(
                                    limit: 30,
                                    obscure: false,
                                    hintText: "Company name",
                                    labelColor: Colorss.forebackground,
                                    maxLines: 1,
                                    controller: controller.companyController,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        SizedBox(height: 10.h),
                        TextfieldWidget(
                          limit: 150,
                          obscure: false,
                          hintText: "description",
                          labelColor: Colorss.forebackground,
                          maxLines: 4,
                          controller: controller.descriptionController,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                                child: TextfieldWidget(
                              labelColor: Colorss.forebackground.withOpacity(0.7),
                              controller: controller.skillsController,
                              limit: 13,
                              obscure: false,
                              hintText: isIntern ? "Skills I want to learn. " : "Skills to be taught.",
                            )),
                            SizedBox(
                              width: 100,
                              child: ButtonWidget(
                                padding: 8,
                                bgColor: isIntern ? Colorss.themeNeon1 : Colorss.themeNeon2,
                                function: controller.addSkills,
                                txt: "+",
                                txtColor: Colorss.backgroundColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Obx(() => SizedBox(
                        height: 40,
                        width: Get.width,
                        child: ListView(scrollDirection: Axis.horizontal, children: [
                          const SizedBox(width: 24),
                          ...controller.skillsList
                              .map((e) => GestureDetector(
                                    onTap: () => controller.skillsList.remove(e),
                                    child: Container(
                                      height: 20,
                                      width: 100,
                                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          boxShadow: [Helper.boxShadow],
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colorss.backgroundColor),
                                      alignment: Alignment.center,
                                      child: Text("#$e", style: Styles.smallTextStyle.copyWith(fontSize: 10)),
                                    ),
                                  ))
                              .toList(),
                        ]),
                      )),
                ],
              ),
            ]),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonWidget(
                  bgColor: isIntern ? Colorss.themeNeon1 : Colorss.themeNeon2,
                  function: () => controller.save(isIntern),
                  txt: "CREATE",
                  txtColor: Colorss.backgroundColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
