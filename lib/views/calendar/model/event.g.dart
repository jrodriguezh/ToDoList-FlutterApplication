// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
