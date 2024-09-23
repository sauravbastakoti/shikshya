// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

List<OnlibNotification> notificationFromJson(String str) =>
    List<OnlibNotification>.from(
        json.decode(str).map((x) => OnlibNotification.fromJson(x)));

String notificationToJson(List<OnlibNotification> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnlibNotification {
  int id;
  String type;
  String title;
  String message;
  String imageUrl;
  String timestamp;

  OnlibNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.imageUrl,
    required this.timestamp,
  });

  factory OnlibNotification.fromJson(Map<String, dynamic> json) =>
      OnlibNotification(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        message: json["message"],
        imageUrl: json["imageUrl"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "message": message,
        "imageUrl": imageUrl,
        "timestamp": timestamp,
      };
}
