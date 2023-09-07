import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdvertisementsService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth userInfo = FirebaseAuth.instance;
  static Future<String?> saveAdvertisement(String description, bool status, List skills, String companyName) async {
    final docRefAll = firestore.collection("Advertisements").doc(userInfo.currentUser!.uid);
    final uid = docRefAll.id;
    try {
      await docRefAll.set({
        "companyName": companyName,
        "skills": skills,
        "description": description,
        "uid": docRefAll.id,
        "email": userInfo.currentUser!.email,
        "name": userInfo.currentUser!.displayName,
        "status": status ? "intern" : "internShip",
        "createdAt": DateTime.now().toString()
      });
    } catch (_) {
      return null;
    }
    return uid;
  }

  static Future<String?> deleteAdvertisement() async {
    final docRefAll = firestore.collection("Advertisements").doc(userInfo.currentUser!.uid);
    final uid = docRefAll.id;
    try {
      await docRefAll.delete();
    } catch (_) {
      return null;
    }
    return uid;
  }
}
