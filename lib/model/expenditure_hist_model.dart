// To parse this JSON data, do
//
//     final expenditureModel = expenditureModelFromJson(jsonString);

import 'dart:convert';

ExpenditureModel expenditureModelFromJson(String str) => ExpenditureModel.fromJson(json.decode(str));

String expenditureModelToJson(ExpenditureModel data) => json.encode(data.toJson());

class ExpenditureModel {
  String? message;
  List<ExpenditureHistory>? expenditureHistory;

  ExpenditureModel({
    this.message,
    this.expenditureHistory,
  });

  factory ExpenditureModel.fromJson(Map<String, dynamic> json) => ExpenditureModel(
    message: json["message"],
    expenditureHistory: List<ExpenditureHistory>.from(json["expenditure_history"].map((x) => ExpenditureHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "expenditure_history": List<dynamic>.from(expenditureHistory!.map((x) => x.toJson())),
  };
}

class ExpenditureHistory {
  int? id;
  String? amcType;
  String? amcCode;
  String? serviceDate;
  String? productCount;
  String? maintenenceCharge;
  String? sparepartsCharge;
  String? otherCharge;
  String? totalCharge;
  String? status;

  ExpenditureHistory({
    this.id,
    this.amcType,
    this.amcCode,
    this.serviceDate,
    this.productCount,
    this.maintenenceCharge,
    this.sparepartsCharge,
    this.otherCharge,
    this.totalCharge,
    this.status,
  });

  factory ExpenditureHistory.fromJson(Map<String, dynamic> json) => ExpenditureHistory(
    id: json["id"],
    amcType: json["amc_type"],
    amcCode: json["amc_code"],
    serviceDate: json["service_date"],
    productCount: json["product_count"],
    maintenenceCharge: json["maintenence_charge"],
    sparepartsCharge: json["spareparts_charge"],
    otherCharge: json["other_charge"],
    totalCharge: json["total_charge"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amc_type": amcType,
    "amc_code": amcCode,
    "service_date": serviceDate,
    "product_count": productCount,
    "maintenence_charge": maintenenceCharge,
    "spareparts_charge": sparepartsCharge,
    "other_charge": otherCharge,
    "total_charge": totalCharge,
    "status": status,
  };
}
