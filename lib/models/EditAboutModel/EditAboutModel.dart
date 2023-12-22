
import 'dart:convert';

EditAboutModel editAboutModelFromJson(String str) => EditAboutModel.fromJson(json.decode(str));

String editAboutModelToJson(EditAboutModel data) => json.encode(data.toJson());

class EditAboutModel {
  bool? status;
  String? message;

  EditAboutModel({
    this.status,
    this.message,
  });

  factory EditAboutModel.fromJson(Map<String, dynamic> json) => EditAboutModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
