import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const String tableEvents = "events";

class EventFields {
  static final List<String> values = [
    id,
    title,
    description,
    starts,
    ends,
    isAllDay,
    ownerUserId,
  ];

  static const String id = "id";
  static const String title = "title";
  static const String description = "description";
  static const String starts = "starts";
  static const String ends = "ends";
  static const String isAllDay = "isAllDay";
  static const String ownerUserId = "ownerUserId";
}

class Event {
  final int? id;
  final String title;
  final String description;
  final DateTime starts;
  final DateTime ends;
  final bool isAllDay;
  final String ownerUserId;

  const Event({
    this.id,
    required this.title,
    required this.description,
    required this.starts,
    required this.ends,
    required this.ownerUserId,
    this.isAllDay = false,
  });

  Event copy({
    int? id,
    String? title,
    String? description,
    DateTime? starts,
    DateTime? ends,
    bool? isAllDay,
    String? ownerUserId,
  }) =>
      Event(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        starts: starts ?? this.starts,
        ends: ends ?? this.ends,
        isAllDay: isAllDay ?? this.isAllDay,
        ownerUserId: ownerUserId ?? this.ownerUserId,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "starts": starts,
        "ends": ends,
        "isAllDay": isAllDay,
        "ownerUserId": ownerUserId,
      };

  Map<String, Object?> toJsonSql() => {
        EventFields.id: id,
        EventFields.title: title,
        EventFields.description: description,
        EventFields.starts: starts.toIso8601String(),
        EventFields.ends: ends.toIso8601String(),
        EventFields.isAllDay: isAllDay ? 1 : 0,
        EventFields.ownerUserId: ownerUserId,
      };

  static Event fromJson(Map<String, Object?> json) => Event(
        id: json[EventFields.id] as int?,
        title: json[EventFields.title] as String,
        description: json[EventFields.description] as String,
        starts: DateTime.parse(json[EventFields.starts] as String),
        ends: DateTime.parse(json[EventFields.ends] as String),
        isAllDay: json[EventFields.isAllDay] == 1,
        ownerUserId: json[EventFields.ownerUserId] as String,
      );

  factory Event.fromMap(Map<dynamic, dynamic> map) {
    return Event(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      starts: map['from'] ?? '',
      ends: map['to'] ?? '',
      isAllDay: map['isAllDay'] ?? '',
      ownerUserId: map['ownerUserId'] ?? '',
    );
  }
}
