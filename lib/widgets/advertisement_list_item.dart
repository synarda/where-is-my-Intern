// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:whereismyintern/controllers/home_controller.dart';
import 'package:whereismyintern/controllers/profile_controller.dart';
import 'package:whereismyintern/models/advertisement_model.dart';
import 'package:whereismyintern/screens/intern_detail.dart';
import 'package:whereismyintern/screens/internship_detail.dart';
import 'package:whereismyintern/utils/const.dart';
import 'package:whereismyintern/utils/helper.dart';
import 'package:whereismyintern/widgets/custom_future.dart';

class AdvertisementListItemWidget extends StatelessWidget {
  const AdvertisementListItemWidget({
    Key? key,
    required this.ad,
    this.pPhoto,
  }) : super(key: key);
  final AdvertisementModel ad;
  final Future<String>? pPhoto;

  @override
  Widget build(BuildContext context) {
    final controllerProfile = Get.find<ProfileController>();
    final controller = Get.find<HomeController>();
    final color = ad.status == "intern" ? Colorss.themeNeon1 : Colorss.themeNeon2;
    return GestureDetector(
      onTap: ad.status == "intern"
          ? () => Get.to(InternDetailPage(
                qrCode: controller.qrLink.value,
                ad: AdvertisementModel(
                    createdAt: ad.createdAt,
                    description: ad.description,
                    companyName: ad.companyName,
                    email: ad.email,
                    name: ad.name,
                    skills: ad.skills,
                    status: ad.status,
                    uid: ad.uid),
                pPhoto: pPhoto,
              ))
          : () => Get.to(InternshipDetailPage(
                ad: AdvertisementModel(
                    companyName: ad.companyName,
                    createdAt: ad.createdAt,
                    description: ad.description,
                    email: ad.email,
                    name: ad.name,
                    skills: ad.skills,
                    status: ad.status,
                    uid: ad.uid),
                pPhoto: pPhoto,
              )),
      child: Container(
        height: 150.h,
        width: Get.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colorss.backgroundColor.withOpacity(0.2),
          ),
          color: color,
          boxShadow: [Helper.boxShadow],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 16),
                    CustomFutureBuilderWidget(size: 70, future: pPhoto),
                    const SizedBox(width: 8),
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 180.w,
                          child: Text(ad.status == "intern" ? ad.name : ad.companyName.toUpperCase(),
                              textAlign: TextAlign.start,
                              style: Styles.smallTextStyle
                                  .copyWith(fontSize: 16, fontWeight: FontWeight.w900, color: Colorss.backgroundColor)),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 180.w,
                          height: 40.h,
                          child: Text(
                            ad.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Styles.smallTextStyle
                                .copyWith(fontSize: 12, color: Colorss.backgroundColor.withOpacity(0.6)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ad.status == "intern"
                    ? FutureBuilder(
                        future: controllerProfile.storage.downloadURLCV(ad.email),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            controller.qrLink.value = snapshot.data.toString();
                            return Hero(
                              tag: ad.uid,
                              child: QrImageView(
                                data: snapshot.data.toString(),
                                version: QrVersions.auto,
                                size: 70.0,
                              ),
                            );
                          }

                          return Container(
                            height: 50,
                            width: 50,
                            color: Colors.transparent,
                          );
                        })
                    : Container(
                        height: 50,
                        width: 50,
                        color: Colors.transparent,
                      ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 40,
              width: Get.width - 70.w,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: ad.skills
                    .map((e) => Container(
                          height: 20,
                          width: 100,
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          padding: const EdgeInsets.all(4),
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colorss.backgroundColor),
                          alignment: Alignment.center,
                          child: Text("#$e",
                              style: Styles.smallTextStyle
                                  .copyWith(fontSize: 10, fontWeight: FontWeight.w900, color: color)),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
