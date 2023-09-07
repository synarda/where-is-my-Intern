import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteController extends GetxController {
  int pageIdx = 0;
  final controller = PageController(initialPage: 0);
}
