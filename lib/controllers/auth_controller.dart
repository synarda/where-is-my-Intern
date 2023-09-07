import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/screens/login_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = Rxn<User>();

  Future<void> signOut() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);

    await _auth.signOut();
    Get.off(const LoginPage());

    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    user.bindStream(_auth.userChanges());
    super.onInit();
  }
}
