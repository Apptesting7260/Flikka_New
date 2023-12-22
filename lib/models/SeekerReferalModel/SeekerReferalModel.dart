// To parse this JSON data, do
//
//     final seekerReferalModel = seekerReferalModelFromJson(jsonString);

import 'dart:convert';

SeekerReferralModel seekerReferralModelFromJson(String str) => SeekerReferralModel.fromJson(json.decode(str));

String seekerReferralModelToJson(SeekerReferralModel data) => json.encode(data.toJson());

class SeekerReferralModel {
  bool? status;
  String? message;
  String? referralBy;
  String? token;

  SeekerReferralModel({
    this.status,
    this.message,
    this.referralBy,
    this.token,
  });

  factory SeekerReferralModel.fromJson(Map<String, dynamic> json) => SeekerReferralModel(
    status: json["status"],
    message: json["message"],
    referralBy: json["referral_by"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "referral_by": referralBy,
    "token": token,
  };
}
