// To parse this JSON data, do
//
//     final getNonAmcFeedback = getNonAmcFeedbackFromJson(jsonString);

import 'dart:convert';

GetNonAmcFeedback getNonAmcFeedbackFromJson(String str) => GetNonAmcFeedback.fromJson(json.decode(str));

String getNonAmcFeedbackToJson(GetNonAmcFeedback data) => json.encode(data.toJson());

class GetNonAmcFeedback {
  String? message;
  List<NonamcServiceList>? nonamcServiceList;

  GetNonAmcFeedback({
    this.message,
    this.nonamcServiceList,
  });

  factory GetNonAmcFeedback.fromJson(Map<String, dynamic> json) => GetNonAmcFeedback(
    message: json["message"],
    nonamcServiceList: List<NonamcServiceList>.from(json["nonamc_service_list"].map((x) => NonamcServiceList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "nonamc_service_list": List<dynamic>.from(nonamcServiceList!.map((x) => x.toJson())),
  };
}

class NonamcServiceList {
  int? id;
  String? serviceDate;
  String? productCount;
  String? demand;
  String? amcType;
  String? executive;
  int? feedbackStatus;

  NonamcServiceList({
    this.id,
    this.serviceDate,
    this.productCount,
    this.demand,
    this.amcType,
    this.executive,
    this.feedbackStatus,

  });

  factory NonamcServiceList.fromJson(Map<String, dynamic> json) => NonamcServiceList(
    id: json["id"],
    serviceDate: json["service_date"],
    productCount: json["product_count"],
    demand: json["demand"],
    amcType: json["amc_type"],
    executive: json["executive"],
    feedbackStatus: json["feedback_status"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_date": serviceDate,
    "product_count": productCount,
    "demand": demand,
    "amc_type": amcType,
    "executive": executive,
    "feedback_status": feedbackStatus,

  };
}
