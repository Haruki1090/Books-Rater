// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentDataImpl _$$CommentDataImplFromJson(Map<String, dynamic> json) =>
    _$CommentDataImpl(
      comment: json['comment'] as String,
      commentator: json['commentator'] as String,
      commentedAt: const DateTimeTimestampConverter()
          .fromJson(json['commentedAt'] as Timestamp),
    );

Map<String, dynamic> _$$CommentDataImplToJson(_$CommentDataImpl instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'commentator': instance.commentator,
      'commentedAt':
          const DateTimeTimestampConverter().toJson(instance.commentedAt),
    };
