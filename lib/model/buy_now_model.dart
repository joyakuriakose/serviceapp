// To parse this JSON data, do
//
//     final buyNowModel = buyNowModelFromJson(jsonString);

import 'dart:convert';

BuyNowModel buyNowModelFromJson(String str) => BuyNowModel.fromJson(json.decode(str));

String buyNowModelToJson(BuyNowModel data) => json.encode(data.toJson());

class BuyNowModel {
  String? message;

  BuyNowModel({
    this.message,
  });

  factory BuyNowModel.fromJson(Map<String, dynamic> json) => BuyNowModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
