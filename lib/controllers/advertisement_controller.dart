import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/controllers/home_controller.dart';
import 'package:whereismyintern/services/create_advertisement_service.dart';
import 'package:whereismyintern/services/storage_service.dart';
import 'package:whereismyintern/utils/alerts.dart';

class AdvertisementController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  final skillsList = [].obs;
  final checkCv = false.obs;
  final Storage storage = Storage();
  static FirebaseAuth userInfo = FirebaseAuth.instance;
  final cvLink = "".obs;
  void save(bool status) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    if (descriptionController.text.isNotEmpty && skillsList.isNotEmpty && status == false
        ? (companyController.text.isNotEmpty)
        : true) {
      if (checkCv.value == status) {
        final result = await AdvertisementsService.saveAdvertisement(
            descriptionController.text, status, skillsList, status ? "" : companyController.text);
        if (result != null) {
          Alerts.showAlert("Create Advertisement");
          skillsList.clear();
          Get.back();
          Get.find<HomeController>().getData();
          EasyLoading.dismiss();
        }
      } else {
        Alerts.showError(status ? "please add cv" : "please add Company Photo");
      }
    } else {
      Alerts.showError("Please fill in all fields.");
    }
  }

  void addSkills() {
    if (skillsController.text.isNotEmpty) {
      if (skillsList.length <= 4) {
        skillsList.add(skillsController.text);
        skillsController.clear();
      } else {
        Alerts.showError("Enough");
      }
    } else {
      Alerts.showError("please Enter skill");
    }
  }

  void addCV() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);

      final results = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
      final path = results!.files.single.path;
      final filename = results.files.single.name;
      storage.uploadCV(path!, filename).then((value) {
        checkCv.value = true;
        Alerts.showAlert("Cv Saved");
        EasyLoading.dismiss();
      });
    } catch (_) {
      Alerts.showError("ERROR");
    }
  }
}
