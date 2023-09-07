import 'dart:convert';

import 'package:flutter/foundation.dart';

class AdvertisementModel {
  final String description;
  final String uid;
  final String name;
  final String status;
  final String email;
  final List skills;
  final String createdAt;
  final String companyName;
  AdvertisementModel({
    required this.description,
    required this.uid,
    required this.name,
    required this.status,
    required this.email,
    required this.skills,
    required this.createdAt,
    required this.companyName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'uid': uid,
      'name': name,
      'status': status,
      'email': email,
      'skills': skills,
      'createdAt': createdAt,
      'companyName': companyName,
    };
  }

  factory AdvertisementModel.fromMap(Map<String, dynamic> map) {
    return AdvertisementModel(
        description: map['description'] as String,
        uid: map['uid'] as String,
        name: map['name'] as String,
        status: map['status'] as String,
        email: map['email'] as String,
        createdAt: map['createdAt'] as String,
        companyName: map['companyName'] as String,
        skills: List.from(
          (map['skills'] as List),
        ));
  }

  AdvertisementModel copyWith({
    String? description,
    String? uid,
    String? name,
    String? status,
    String? email,
    List? skills,
    String? createdAt,
    String? companyName,
  }) {
    return AdvertisementModel(
      description: description ?? this.description,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      status: status ?? this.status,
      email: email ?? this.email,
      skills: skills ?? this.skills,
      createdAt: createdAt ?? this.createdAt,
      companyName: companyName ?? this.companyName,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdvertisementModel.fromJson(String source) =>
      AdvertisementModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdvertisementModel(description: $description, uid: $uid, name: $name, status: $status, email: $email, skills: $skills, createdAt: $createdAt, companyName: $companyName)';
  }

  @override
  bool operator ==(covariant AdvertisementModel other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.uid == uid &&
        other.name == name &&
        other.status == status &&
        other.email == email &&
        listEquals(other.skills, skills) &&
        other.createdAt == createdAt &&
        other.companyName == companyName;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        uid.hashCode ^
        name.hashCode ^
        status.hashCode ^
        email.hashCode ^
        skills.hashCode ^
        createdAt.hashCode ^
        companyName.hashCode;
  }
}
