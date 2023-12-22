
import 'dart:convert';

OtpVerificationModel otpVerificationModelFromJson(String str) => OtpVerificationModel.fromJson(json.decode(str));

String otpVerificationModelToJson(OtpVerificationModel data) => json.encode(data.toJson());

class OtpVerificationModel {
  var status;
  String? message;
  String? token;

  OtpVerificationModel({
    this.status,
    this.message,
    this.token,
  });

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) => OtpVerificationModel(
    status: json["status"],
    message: json["message"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": token,
  };
}
