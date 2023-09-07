import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:whereismyintern/models/advertisement_model.dart';

class HomeController extends GetxController {
  final reference = FirebaseFirestore.instance.collection("Advertisements");
  final dataList = <AdvertisementModel>[].obs;
  final qrLink = "".obs;
  @override
  void onInit() {
    getData();
    EasyLoading.dismiss();
    super.onInit();
  }

  Future<void> getData() async {
    final querySnapshot = await reference.get();
    dataList.value = querySnapshot.docs.map((doc) => AdvertisementModel.fromMap(doc.data())).toList();
  }
}
