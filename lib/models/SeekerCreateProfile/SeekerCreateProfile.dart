// To parse this JSON data, do
//
//     final seekerCreateProfile = seekerCreateProfileFromJson(jsonString);

import 'dart:convert';

SeekerCreateProfile seekerCreateProfileFromJson(String str) => SeekerCreateProfile.fromJson(json.decode(str));

String seekerCreateProfileToJson(SeekerCreateProfile data) => json.encode(data.toJson());

class SeekerCreateProfile {
  bool? status;
  String? message;

  SeekerCreateProfile({
    this.status,
    this.message,
  });

  factory SeekerCreateProfile.fromJson(Map<String, dynamic> json) => SeekerCreateProfile(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
