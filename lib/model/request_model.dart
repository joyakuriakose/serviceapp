// To parse this JSON data, do
//
//     final serviceRequest = serviceRequestFromJson(jsonString);

import 'dart:convert';

ServiceRequest serviceRequestFromJson(String str) => ServiceRequest.fromJson(json.decode(str));

String serviceRequestToJson(ServiceRequest data) => json.encode(data.toJson());

class ServiceRequest {
  String message;

  ServiceRequest({
    required this.message,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
