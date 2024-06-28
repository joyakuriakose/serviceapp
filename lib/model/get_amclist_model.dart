// To parse this JSON data, do
//
//     final getAmcList = getAmcListFromJson(jsonString);

import 'dart:convert';

GetAmcList getAmcListFromJson(String str) => GetAmcList.fromJson(json.decode(str));

String getAmcListToJson(GetAmcList data) => json.encode(data.toJson());

class GetAmcList {
  String message;
  List<AmcList> amcList;

  GetAmcList({
    required this.message,
    required this.amcList,
  });

  factory GetAmcList.fromJson(Map<String, dynamic> json) => GetAmcList(
    message: json["message"],
    amcList: List<AmcList>.from(json["amc_list"].map((x) => AmcList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "amc_list": List<dynamic>.from(amcList.map((x) => x.toJson())),
  };
}

class AmcList {
  int? id;
  String? code;
  String? type;
  String? name;
  String? fkPackageId;
  DateTime? startDate;
  DateTime? endDate;
  String? fkCustomerId;
  String? createdBy;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? renew;
  String? old;
  String? fkAmcParentId;

  AmcList({
     this.id,
     this.code,
     this.type,
     this.name,
     this.fkPackageId,
     this.startDate,
     this.endDate,
     this.fkCustomerId,
     this.createdBy,
     this.status,
     this.createdAt,
     this.updatedAt,
     this.renew,
     this.old,
     this.fkAmcParentId,
  });

  factory AmcList.fromJson(Map<String, dynamic> json) => AmcList(
    id: json["id"],
    code: json["code"],
    type: json["type"],
    name: json["name"],
    fkPackageId: json["fk_package_id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    fkCustomerId: json["fk_customer_id"],
    createdBy: json["created_by"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    renew: json["renew"],
    old: json["old"],
    fkAmcParentId: json["fk_amc_parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "type": type,
    "name": name,
    "fk_package_id": fkPackageId,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "fk_customer_id": fkCustomerId,
    "created_by": createdBy,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "renew": renew,
    "old": old,
    "fk_amc_parent_id": fkAmcParentId,
  };
}
