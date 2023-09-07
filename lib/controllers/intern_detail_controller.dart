import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:whereismyintern/controllers/home_controller.dart';
import 'package:whereismyintern/services/create_advertisement_service.dart';
import 'package:whereismyintern/utils/alerts.dart';

class InternDetailController extends GetxController {
  final panelController = PanelController();
  final sliderPosition = 1.0.obs;
  final FirebaseAuth userInfo = FirebaseAuth.instance;

  void delete() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    final result = await AdvertisementsService.deleteAdvertisement();
    if (result != null) {
      Alerts.showAlert("delete Advertisement");
      Get.back();
      Get.find<HomeController>().getData();
      EasyLoading.dismiss();
    } else {
      Alerts.showError("Error");
    }
  }

  @override
  void onClose() {
    sliderPosition.value = 0;
    super.onClose();
  }
}
