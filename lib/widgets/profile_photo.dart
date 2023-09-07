// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whereismyintern/utils/const.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({
    Key? key,
    this.future,
    required this.size,
    required this.borderSize,
    required this.iconSize,
    required this.borderColor,
  }) : super(key: key);
  final Future<String>? future;
  final double size;
  final double borderSize;
  final double iconSize;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: FutureBuilder(
          future: future,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              return SizedBox(
                width: size,
                height: size,
                child: CachedNetworkImage(
                  height: size,
                  width: size,
                  fit: BoxFit.cover,
                  imageUrl: snapshot.data ?? "",
                  progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                    child: CupertinoActivityIndicator(color: Colorss.themeNeon1),
                  ),
                  errorWidget: (context, url, error) => Image.asset("assets/png/noPhoto.png"),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasData) {
              return Container(
                  color: Colorss.backgroundColor,
                  width: size,
                  height: size,
                  child: const CupertinoActivityIndicator(color: Colorss.themeNeon1));
            }
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colorss.backgroundColor,
                  border: Border.all(color: borderColor, width: borderSize)),
              child: Icon(
                Icons.person,
                color: Colorss.themeNeon1,
                size: iconSize,
              ),
            );
          }),
    );
  }
}
