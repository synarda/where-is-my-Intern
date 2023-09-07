import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User> singin(String email, String password) async {
    var user = await auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user!;
  }

  Future<void> signUpWithEmail(String email, String password, String name) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    try {
      final userCredentials = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredentials.user?.updateDisplayName(name);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  singout() async {
    return await auth.signOut();
  }
}
