// To parse this JSON data, do
//
//     final apiFeedbackResp = apiFeedbackRespFromJson(jsonString);

import 'dart:convert';

ApiFeedbackResp apiFeedbackRespFromJson(String str) => ApiFeedbackResp.fromJson(json.decode(str));

String apiFeedbackRespToJson(ApiFeedbackResp data) => json.encode(data.toJson());

class ApiFeedbackResp {
  String message;

  ApiFeedbackResp({
    required this.message,
  });

  factory ApiFeedbackResp.fromJson(Map<String, dynamic> json) => ApiFeedbackResp(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
