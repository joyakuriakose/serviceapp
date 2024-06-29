// To parse this JSON data, do
//
//     final requestError = requestErrorFromJson(jsonString);

import 'dart:convert';

RequestError requestErrorFromJson(String str) => RequestError.fromJson(json.decode(str));

String requestErrorToJson(RequestError data) => json.encode(data.toJson());

class RequestError {
  String error;

  RequestError({
    required this.error,
  });

  factory RequestError.fromJson(Map<String, dynamic> json) => RequestError(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
