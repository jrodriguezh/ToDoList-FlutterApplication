import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final bool isAllDay;
  final String ownerUserId;

  const Event({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    required this.ownerUserId,
    this.isAllDay = false,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "from": from,
        "to": to,
        "isAllDay": isAllDay,
        "ownerUserId": ownerUserId,
      };

  static Event fromJson(Map<String, dynamic> json) => Event(
      title: json["title"],
      description: json["descripcion"],
      from: json["from"],
      to: json["to"],
      ownerUserId: json["ownerUserId"]);

  factory Event.fromMap(Map<dynamic, dynamic> map) {
    return Event(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      isAllDay: map['isAllDay'] ?? '',
      ownerUserId: map['ownerUserId'] ?? '',
    );
  }
}
