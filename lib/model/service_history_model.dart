// To parse this JSON data, do
//
//     final serviceHistoryModel = serviceHistoryModelFromJson(jsonString);

import 'dart:convert';

ServiceHistoryModel serviceHistoryModelFromJson(String str) => ServiceHistoryModel.fromJson(json.decode(str));

String serviceHistoryModelToJson(ServiceHistoryModel data) => json.encode(data.toJson());

class ServiceHistoryModel {
  String? message;
  List<ServiceHistory>? serviceHistory;

  ServiceHistoryModel({
    this.message,
    this.serviceHistory,
  });

  factory ServiceHistoryModel.fromJson(Map<String, dynamic> json) => ServiceHistoryModel(
    message: json["message"],
    serviceHistory: List<ServiceHistory>.from(json["service_history"].map((x) => ServiceHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "service_history": List<dynamic>.from(serviceHistory!.map((x) => x.toJson())),
  };
}

class ServiceHistory {
  int? id;
  String? serviceDate;
  String? productCount;
  String? demand;
  String? amcType;
  String? amcCode;

  ServiceHistory({
    this.id,
    this.serviceDate,
    this.productCount,
    this.demand,
    this.amcType,
    this.amcCode,
  });

  factory ServiceHistory.fromJson(Map<String, dynamic> json) => ServiceHistory(
    id: json["id"],
    serviceDate: json["service_date"],
    productCount: json["product_count"],
    demand: json["demand"],
    amcType: json["amc_type"],
    amcCode: json["amc_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_date": serviceDate,
    "product_count": productCount,
    "demand": demand,
    "amc_type": amcType,
    "amc_code": amcCode,
  };
}
