import 'package:get/get.dart';
import 'package:whereismyintern/controllers/auth_controller.dart';
import 'package:whereismyintern/controllers/profile_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(ProfileController());
  }
}
