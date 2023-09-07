import 'package:flutter_easyloading/flutter_easyloading.dart';

class Alerts {
  static Future<void> showAlert(String message) async {
    EasyLoading.showToast(message, dismissOnTap: true, maskType: EasyLoadingMaskType.none);
  }

  static Future<void> showError(String message) async {
    EasyLoading.showError(message, dismissOnTap: true, maskType: EasyLoadingMaskType.none);
  }
}
