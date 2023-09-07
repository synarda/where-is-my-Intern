// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whereismyintern/utils/const.dart';
import 'package:whereismyintern/utils/helper.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    Key? key,
    this.label,
    this.hintText,
    this.icon,
    this.suffIcon,
    this.controller,
    required this.limit,
    this.fontsize,
    required this.obscure,
    this.readOnly = false,
    this.type,
    this.focus = false,
    this.onChanged,
    this.preffixIconFunc,
    this.focusNode,
    this.fillColor = Colorss.backgroundColor,
    this.borderColor = Colors.transparent,
    this.labelColor = Colorss.textColor,
    this.radius = 1,
    this.maxLines = 1,
  }) : super(key: key);

  final String? label;
  final String? hintText;
  final Widget? icon;
  final Widget? suffIcon;

  final TextEditingController? controller;
  final int limit;
  final double? fontsize;
  final bool obscure;
  final bool readOnly;

  final TextInputType? type;
  final bool focus;
  final Function(String)? onChanged;
  final void Function()? preffixIconFunc;
  final FocusNode? focusNode;
  final Color fillColor;
  final Color borderColor;
  final Color labelColor;
  final double radius;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        boxShadow: [Helper.boxShadow],
      ),
      child: TextField(
        maxLines: maxLines,
        minLines: maxLines,
        readOnly: readOnly,
        focusNode: focusNode,
        autofocus: focus,
        keyboardType: type,
        obscureText: obscure,
        style: Styles.smallTextStyle.copyWith(color: labelColor, fontWeight: FontWeight.w500),
        inputFormatters: [
          LengthLimitingTextInputFormatter(limit),
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          suffixIcon: suffIcon,
          hintText: hintText,
          hintStyle: Styles.smallTextStyle.copyWith(color: labelColor, fontWeight: FontWeight.w500, fontSize: 15),
          prefixIcon: icon == null
              ? null
              : IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: icon ?? const SizedBox(),
                  onPressed: preffixIconFunc,
                  color: Colorss.textColor,
                ),
          labelText: label,
          labelStyle:
              Styles.smallTextStyle.copyWith(color: labelColor, fontWeight: FontWeight.w500, fontSize: fontsize ?? 15),
          filled: true,
          fillColor: fillColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: borderColor.withOpacity(0.3)),
          ),
        ),
        cursorColor: Colorss.textColor,
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
