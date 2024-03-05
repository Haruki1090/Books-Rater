// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoritesData _$FavoritesDataFromJson(Map<String, dynamic> json) {
  return _FavoritesData.fromJson(json);
}

/// @nodoc
mixin _$FavoritesData {
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavoritesDataCopyWith<FavoritesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesDataCopyWith<$Res> {
  factory $FavoritesDataCopyWith(
          FavoritesData value, $Res Function(FavoritesData) then) =
      _$FavoritesDataCopyWithImpl<$Res, FavoritesData>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String username,
      String imageUrl,
      @DateTimeTimestampConverter() DateTime createdAt});
}

/// @nodoc
class _$FavoritesDataCopyWithImpl<$Res, $Val extends FavoritesData>
    implements $FavoritesDataCopyWith<$Res> {
  _$FavoritesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? username = null,
    Object? imageUrl = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoritesDataImplCopyWith<$Res>
    implements $FavoritesDataCopyWith<$Res> {
  factory _$$FavoritesDataImplCopyWith(
          _$FavoritesDataImpl value, $Res Function(_$FavoritesDataImpl) then) =
      __$$FavoritesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String username,
      String imageUrl,
      @DateTimeTimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$FavoritesDataImplCopyWithImpl<$Res>
    extends _$FavoritesDataCopyWithImpl<$Res, _$FavoritesDataImpl>
    implements _$$FavoritesDataImplCopyWith<$Res> {
  __$$FavoritesDataImplCopyWithImpl(
      _$FavoritesDataImpl _value, $Res Function(_$FavoritesDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? username = null,
    Object? imageUrl = null,
    Object? createdAt = null,
  }) {
    return _then(_$FavoritesDataImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoritesDataImpl implements _FavoritesData {
  const _$FavoritesDataImpl(
      {required this.uid,
      required this.email,
      required this.username,
      required this.imageUrl,
      @DateTimeTimestampConverter() required this.createdAt});

  factory _$FavoritesDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoritesDataImplFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String username;
  @override
  final String imageUrl;
  @override
  @DateTimeTimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'FavoritesData(uid: $uid, email: $email, username: $username, imageUrl: $imageUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesDataImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, email, username, imageUrl, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritesDataImplCopyWith<_$FavoritesDataImpl> get copyWith =>
      __$$FavoritesDataImplCopyWithImpl<_$FavoritesDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoritesDataImplToJson(
      this,
    );
  }
}

abstract class _FavoritesData implements FavoritesData {
  const factory _FavoritesData(
          {required final String uid,
          required final String email,
          required final String username,
          required final String imageUrl,
          @DateTimeTimestampConverter() required final DateTime createdAt}) =
      _$FavoritesDataImpl;

  factory _FavoritesData.fromJson(Map<String, dynamic> json) =
      _$FavoritesDataImpl.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String get username;
  @override
  String get imageUrl;
  @override
  @DateTimeTimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FavoritesDataImplCopyWith<_$FavoritesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
