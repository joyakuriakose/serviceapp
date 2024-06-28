// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String message;
  List<Notification> notification;

  NotificationModel({
    required this.message,
    required this.notification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    message: json["message"],
    notification: List<Notification>.from(json["notification"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "notification": List<dynamic>.from(notification.map((x) => x.toJson())),
  };
}

class Notification {
  int? id;
  String? description;
  String? status;

  Notification({
    this.id,
    this.description,
    this.status,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
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
