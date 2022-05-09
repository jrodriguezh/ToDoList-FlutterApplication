import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part "event.g.dart";

@JsonSerializable()
class EventList {
  EventList({
    required this.event,
  });

  List<Event> event;
  factory EventList.fromJson(Map<String, dynamic> json) =>
      _$EventListFromJson(json);
  Map<String, dynamic> toJson() => _$EventListToJson(this);
}

@JsonSerializable()
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

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
