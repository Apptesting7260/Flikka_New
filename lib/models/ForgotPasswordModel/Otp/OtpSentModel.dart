
import 'dart:convert';

OtpSentModel otpSentModelFromJson(String str) => OtpSentModel.fromJson(json.decode(str));

String otpSentModelToJson(OtpSentModel data) => json.encode(data.toJson());

class OtpSentModel {
  bool? status;
  String? message;

  OtpSentModel({
    this.status,
    this.message,
  });

  factory OtpSentModel.fromJson(Map<String, dynamic> json) => OtpSentModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
