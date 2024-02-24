// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookDataImpl _$$BookDataImplFromJson(Map<String, dynamic> json) =>
    _$BookDataImpl(
      uid: json['uid'] as String,
      banned: json['banned'] as bool,
      email: json['email'] as String,
      bookId: json['bookId'] as String,
      title: json['title'] as String,
      bookImageUrl: json['bookImageUrl'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$BookDataImplToJson(_$BookDataImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'banned': instance.banned,
      'email': instance.email,
      'bookId': instance.bookId,
      'title': instance.title,
      'bookImageUrl': instance.bookImageUrl,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
