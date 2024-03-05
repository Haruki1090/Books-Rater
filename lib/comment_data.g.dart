// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentDataImpl _$$CommentDataImplFromJson(Map<String, dynamic> json) =>
    _$CommentDataImpl(
      comment: json['comment'] as String,
      commentatorUsername: json['commentatorUsername'] as String,
      commentatorUid: json['commentatorUid'] as String,
      commentatorEmail: json['commentatorEmail'] as String,
      commentatorImageUrl: json['commentatorImageUrl'] as String,
      commentedAt: const DateTimeTimestampConverter()
          .fromJson(json['commentedAt'] as Timestamp),
    );

Map<String, dynamic> _$$CommentDataImplToJson(_$CommentDataImpl instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'commentatorUsername': instance.commentatorUsername,
      'commentatorUid': instance.commentatorUid,
      'commentatorEmail': instance.commentatorEmail,
      'commentatorImageUrl': instance.commentatorImageUrl,
      'commentedAt':
          const DateTimeTimestampConverter().toJson(instance.commentedAt),
    };
