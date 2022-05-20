// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventList _$EventListFromJson(Map<String, dynamic> json) => EventList(
      event: (json['event'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventListToJson(EventList instance) => <String, dynamic>{
      'event': instance.event,
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      starts: DateTime.parse(json['starts'] as String),
      ends: DateTime.parse(json['ends'] as String),
      ownerUserId: json['ownerUserId'] as String,
      isAllDay: json['isAllDay'] as bool? ?? false,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'starts': instance.starts.toIso8601String(),
      'ends': instance.ends.toIso8601String(),
      'isAllDay': instance.isAllDay,
      'ownerUserId': instance.ownerUserId,
    };
