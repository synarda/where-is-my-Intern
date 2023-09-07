// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whereismyintern/utils/const.dart';

class CustomFutureBuilderWidget extends StatelessWidget {
  const CustomFutureBuilderWidget({
    Key? key,
    this.future,
    required this.size,
  }) : super(key: key);
  final Future<String>? future;
  final double size;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: CachedNetworkImage(
                height: size.h,
                width: size.w,
                fit: BoxFit.cover,
                imageUrl: snapshot.data ?? "",
                progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                  child: CupertinoActivityIndicator(color: Colorss.themeNeon1),
                ),
                errorWidget: (context, url, error) => Image.asset("assets/png/noPhoto.png"),
              ),
            );
          }

          return Container(
            width: size.h,
            height: size.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colorss.backgroundColor,
                border: Border.all(color: Colorss.themeNeon1, width: 2)),
            child: const Icon(
              Icons.person,
              color: Colorss.themeNeon1,
              size: 30,
            ),
          );
        });
  }
}
