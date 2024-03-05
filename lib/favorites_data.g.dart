// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoritesDataImpl _$$FavoritesDataImplFromJson(Map<String, dynamic> json) =>
    _$FavoritesDataImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      imageUrl: json['imageUrl'] as String,
      createdAt: const DateTimeTimestampConverter()
          .fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$FavoritesDataImplToJson(_$FavoritesDataImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'username': instance.username,
      'imageUrl': instance.imageUrl,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
    };
