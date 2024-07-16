// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String message;
  List<Notificationss> notification;

  NotificationModel({
    required this.message,
    required this.notification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    message: json["message"],
    notification: List<Notificationss>.from(json["notification"].map((x) => Notificationss.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "notification": List<dynamic>.from(notification.map((x) => x.toJson())),
  };
}

class Notificationss {
  int? id;
  String? description;
  String? status;

  Notificationss({
    this.id,
    this.description,
    this.status,
  });

  factory Notificationss.fromJson(Map<String, dynamic> json) => Notificationss(
    id: json["id"],
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "status": status,
  };
}

