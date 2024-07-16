// To parse this JSON data, do
//
//     final packageDetailModel = packageDetailModelFromJson(jsonString);

import 'dart:convert';

PackageDetailModel packageDetailModelFromJson(String str) => PackageDetailModel.fromJson(json.decode(str));

String packageDetailModelToJson(PackageDetailModel data) => json.encode(data.toJson());

class PackageDetailModel {
  String? message;
  AmcDetails? amcDetails;

  PackageDetailModel({
    this.message,
    this.amcDetails,
  });

  factory PackageDetailModel.fromJson(Map<String, dynamic> json) => PackageDetailModel(
    message: json["message"],
    amcDetails: AmcDetails.fromJson(json["amc_details"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "amc_details": amcDetails!.toJson(),
  };
}

class AmcDetails {
  int? remainingCount;
  int? amcId;
  String? amcCode;
  String? packageName;
  String? brandName;
  String? modelName;
  List<ServiceDate>? serviceDates;
  int? productCount;
  String? amcStatus;
  DateTime? amcStart;
  DateTime? amcEnd;

  AmcDetails({
    this.remainingCount,
    this.amcId,
    this.amcCode,
    this.packageName,
    this.brandName,
    this.modelName,
    this.serviceDates,
    this.productCount,
    this.amcStatus,
    this.amcStart,
    this.amcEnd,
  });

  factory AmcDetails.fromJson(Map<String, dynamic> json) => AmcDetails(
    remainingCount: json["remaining_count"],
    amcId: json["amc_id"],
    amcCode: json["amc_code"],
    packageName: json["package_name"],
    brandName: json["brand_name"],
    modelName: json["model_name"],
    serviceDates: List<ServiceDate>.from(json["service_dates"].map((x) => ServiceDate.fromJson(x))),
    productCount: json["product_count"],
    amcStatus: json["amc_status"],
    amcStart: DateTime.parse(json["amc_start"]),
    amcEnd: DateTime.parse(json["amc_end"]),
  );

  Map<String, dynamic> toJson() => {
    "remaining_count": remainingCount,
    "amc_id": amcId,
    "amc_code": amcCode,
    "package_name": packageName,
    "brand_name": brandName,
    "model_name": modelName,
    "service_dates": List<dynamic>.from(serviceDates!.map((x) => x.toJson())),
    "product_count": productCount,
    "amc_status": amcStatus,
    "amc_start": "${amcStart!.year.toString().padLeft(4, '0')}-${amcStart!.month.toString().padLeft(2, '0')}-${amcStart!.day.toString().padLeft(2, '0')}",
    "amc_end": "${amcEnd!.year.toString().padLeft(4, '0')}-${amcEnd!.month.toString().padLeft(2, '0')}-${amcEnd!.day.toString().padLeft(2, '0')}",
  };
}

class ServiceDate {
  int? serviceId;
  DateTime? date;
  String? type;
  String? status;
  int? feedbackStatus;

  ServiceDate({
    this.serviceId,
    this.date,
    this.type,
    this.status,
    this.feedbackStatus,
  });

  factory ServiceDate.fromJson(Map<String, dynamic> json) => ServiceDate(
    serviceId: json["service_id"],
    date: DateTime.parse(json["date"]),
    type: json["type"],
    status: json["status"],
    feedbackStatus: json["feedback_status"],
  );

  Map<String, dynamic> toJson() => {
    "service_id": serviceId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "type": type,
    "status": status,
    "feedback_status": feedbackStatus,
  };
}



// PackageDetailModel packageDetailModelFromJson(String str) => PackageDetailModel.fromJson(json.decode(str));
//
// String packageDetailModelToJson(PackageDetailModel data) => json.encode(data.toJson());
//
// class PackageDetailModel {
//   String message;
//   AmcDetails amcDetails;
//
//   PackageDetailModel({
//     required this.message,
//     required this.amcDetails,
//   });
//
//   factory PackageDetailModel.fromJson(Map<String, dynamic> json) => PackageDetailModel(
//     message: json["message"],
//     amcDetails: AmcDetails.fromJson(json["amc_details"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "amc_details": amcDetails.toJson(),
//   };
// }
//
// class AmcDetails {
//   int? remainingCount;
//   int? amcId;
//   String? amcCode;
//   String? packageName;
//   String? brandName;
//   String? modelName;
//   List<ServiceDate>? serviceDates;
//   int? productCount;
//   String? amcStatus;
//   DateTime? amcStart;
//   DateTime? amcEnd;
//
//   AmcDetails({
//     this.remainingCount,
//     this.amcId,
//     this.amcCode,
//     this.packageName,
//     this.brandName,
//     this.modelName,
//     this.serviceDates,
//     this.productCount,
//     this.amcStatus,
//     this.amcStart,
//     this.amcEnd,
//   });
//
//   factory AmcDetails.fromJson(Map<String, dynamic> json) => AmcDetails(
//     remainingCount: json["remaining_count"],
//     amcId: json["amc_id"],
//     amcCode: json["amc_code"],
//     packageName: json["package_name"],
//     brandName: json["brand_name"],
//     modelName: json["model_name"],
//     serviceDates: List<ServiceDate>.from(json["service_dates"].map((x) => ServiceDate.fromJson(x))),
//     productCount: json["product_count"],
//     amcStatus: json["amc_status"],
//     amcStart: DateTime.parse(json["amc_start"]),
//     amcEnd: DateTime.parse(json["amc_end"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "remaining_count": remainingCount,
//     "amc_id": amcId,
//     "amc_code": amcCode,
//     "package_name": packageName,
//     "brand_name": brandName,
//     "model_name": modelName,
//     "service_dates": List<dynamic>.from(serviceDates!.map((x) => x.toJson())),
//     "product_count": productCount,
//     "amc_status": amcStatus,
//     "amc_start": "${amcStart!.year.toString().padLeft(4, '0')}-${amcStart!.month.toString().padLeft(2, '0')}-${amcStart!.day.toString().padLeft(2, '0')}",
//     "amc_end": "${amcEnd!.year.toString().padLeft(4, '0')}-${amcEnd!.month.toString().padLeft(2, '0')}-${amcEnd!.day.toString().padLeft(2, '0')}",
//   };
// }
//
// class ServiceDate {
//   int? serviceId;
//   DateTime? date;
//   String? type;
//   String? status;
//   int? feedbackStatus;
//
//   ServiceDate({
//     this.serviceId,
//     this.date,
//     this.type,
//     this.status,
//     this.feedbackStatus,
//   });
//
//   factory ServiceDate.fromJson(Map<String, dynamic> json) => ServiceDate(
//     serviceId: json["service_id"],
//     date: DateTime.parse(json["date"]),
//     type: json["type"],
//     status: json["status"],
//     feedbackStatus: json["feedback_status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "service_id": serviceId,
//     "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
//     "type": type,
//     "status": status,
//     "feedback_status": feedbackStatus,
//   };
// }


