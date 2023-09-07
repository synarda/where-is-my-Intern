import 'package:flutter/material.dart';
import 'package:whereismyintern/utils/const.dart';

class Helper {
  static BoxShadow get boxShadow => BoxShadow(
        color: Colors.black.withOpacity(0.3),
        spreadRadius: 1,
        blurRadius: 15,
        offset: const Offset(0, 10),
      );
  static LinearGradient get mainLinearGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colorss.themeNeon1,
          Colorss.backgroundColor.withOpacity(0.9),
        ],
      );
}
