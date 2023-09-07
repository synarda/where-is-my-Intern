import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_core/firebase_core.dart" as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:whereismyintern/utils/alerts.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
    String filepath,
    String filename,
  ) async {
    File file = File(filepath);

    FirebaseAuth user = FirebaseAuth.instance;
    FirebaseFirestore.instance.collection("Person").where("email", isEqualTo: user.currentUser!.email);

    try {
      await storage.ref("profil/photos/${user.currentUser!.email}").putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      Alerts.showError(e.toString());
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref("profil").listAll();

    for (var ref in results.items) {
      Alerts.showAlert("file is found: $ref");
    }
    return results;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref("profil/photos/$imageName").getDownloadURL();
    return downloadURL;
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> uploadCV(
    String filepath,
    String filename,
  ) async {
    File file = File(filepath);
    FirebaseAuth user = FirebaseAuth.instance;
    FirebaseFirestore.instance.collection("Person").where("email", isEqualTo: user.currentUser!.email);
    try {
      await storage.ref("profil/cvs/${user.currentUser!.email}").putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      Alerts.showError(e.toString());
    }
  }

  Future<firebase_storage.ListResult> listFilesCV() async {
    firebase_storage.ListResult results = await storage.ref("profil").listAll();
    for (var ref in results.items) {
      Alerts.showAlert("file is found: $ref");
    }
    return results;
  }

  Future<String> downloadURLCV(String cvName) async {
    String downloadURL = await storage.ref("profil/cvs/$cvName").getDownloadURL();
    return downloadURL;
  }
}
