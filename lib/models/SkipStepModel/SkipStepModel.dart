// To parse this JSON data, do
//
//     final skipStepModel = skipStepModelFromJson(jsonString);

import 'dart:convert';

SkipStepModel skipStepModelFromJson(String str) => SkipStepModel.fromJson(json.decode(str));

String skipStepModelToJson(SkipStepModel data) => json.encode(data.toJson());

class SkipStepModel {
  bool? status;
  dynamic step;

  SkipStepModel({
    this.status,
    this.step,
  });

  factory SkipStepModel.fromJson(Map<String, dynamic> json) => SkipStepModel(
    status: json["status"],
    step: json["step"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "step": step,
  };
}
