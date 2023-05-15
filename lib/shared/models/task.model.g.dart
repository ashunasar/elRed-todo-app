// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String?,
      uId: json['uId'] as String,
      emojiDataId: json['emojiDataId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: const TimestampConverter().fromJson(json['date'] as Timestamp),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'uId': instance.uId,
      'emojiDataId': instance.emojiDataId,
      'title': instance.title,
      'description': instance.description,
      'date': const TimestampConverter().toJson(instance.date),
    };
