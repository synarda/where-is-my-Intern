import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/services/storage_service.dart';
import 'package:whereismyintern/utils/alerts.dart';

class ProfileController extends GetxController {
  final Storage storage = Storage();
  static FirebaseAuth userInfo = FirebaseAuth.instance;

  void addPhoto() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);

      final results = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ["png", "jpg"]);
      final path = results!.files.single.path;
      final filename = results.files.single.name;
      storage.uploadFile(path!, filename).then((value) {
        EasyLoading.dismiss();
        Alerts.showAlert("Photo Saved");
      });
    } catch (_) {
      Alerts.showError("ERROR");
    }
  }
}
