// To parse this JSON data, do
//
//     final checkSocialLoginModel = checkSocialLoginModelFromJson(jsonString);

import 'dart:convert';

CheckSocialLoginModel checkSocialLoginModelFromJson(String str) => CheckSocialLoginModel.fromJson(json.decode(str));

String checkSocialLoginModelToJson(CheckSocialLoginModel data) => json.encode(data.toJson());

class CheckSocialLoginModel {
  bool? status;
  bool? emailRegistered;
  dynamic role;
  dynamic step;

  CheckSocialLoginModel({
    this.status,
    this.emailRegistered,
    this.role,
    this.step,
  });

  factory CheckSocialLoginModel.fromJson(Map<String, dynamic> json) => CheckSocialLoginModel(
    status: json["status"],
    emailRegistered: json["email_registered"],
    role: json["role"],
    step: json["step"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "email_registered": emailRegistered,
    "role": role,
    "step": step,
  };
}
