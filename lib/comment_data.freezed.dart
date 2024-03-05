// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommentData _$CommentDataFromJson(Map<String, dynamic> json) {
  return _CommentData.fromJson(json);
}

/// @nodoc
mixin _$CommentData {
  String get comment => throw _privateConstructorUsedError;
  String get commentatorUsername => throw _privateConstructorUsedError;
  String get commentatorUid => throw _privateConstructorUsedError;
  String get commentatorEmail => throw _privateConstructorUsedError;
  String get commentatorImageUrl => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime get commentedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentDataCopyWith<CommentData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentDataCopyWith<$Res> {
  factory $CommentDataCopyWith(
          CommentData value, $Res Function(CommentData) then) =
      _$CommentDataCopyWithImpl<$Res, CommentData>;
  @useResult
  $Res call(
      {String comment,
      String commentatorUsername,
      String commentatorUid,
      String commentatorEmail,
      String commentatorImageUrl,
      @DateTimeTimestampConverter() DateTime commentedAt});
}

/// @nodoc
class _$CommentDataCopyWithImpl<$Res, $Val extends CommentData>
    implements $CommentDataCopyWith<$Res> {
  _$CommentDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment = null,
    Object? commentatorUsername = null,
    Object? commentatorUid = null,
    Object? commentatorEmail = null,
    Object? commentatorImageUrl = null,
    Object? commentedAt = null,
  }) {
    return _then(_value.copyWith(
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      commentatorUsername: null == commentatorUsername
          ? _value.commentatorUsername
          : commentatorUsername // ignore: cast_nullable_to_non_nullable
              as String,
      commentatorUid: null == commentatorUid
          ? _value.commentatorUid
          : commentatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      commentatorEmail: null == commentatorEmail
          ? _value.commentatorEmail
          : commentatorEmail // ignore: cast_nullable_to_non_nullable
              as String,
      commentatorImageUrl: null == commentatorImageUrl
          ? _value.commentatorImageUrl
          : commentatorImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      commentedAt: null == commentedAt
          ? _value.commentedAt
          : commentedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentDataImplCopyWith<$Res>
    implements $CommentDataCopyWith<$Res> {
  factory _$$CommentDataImplCopyWith(
          _$CommentDataImpl value, $Res Function(_$CommentDataImpl) then) =
      __$$CommentDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String comment,
      String commentatorUsername,
      String commentatorUid,
      String commentatorEmail,
      String commentatorImageUrl,
      @DateTimeTimestampConverter() DateTime commentedAt});
}

/// @nodoc
class __$$CommentDataImplCopyWithImpl<$Res>
    extends _$CommentDataCopyWithImpl<$Res, _$CommentDataImpl>
    implements _$$CommentDataImplCopyWith<$Res> {
  __$$CommentDataImplCopyWithImpl(
      _$CommentDataImpl _value, $Res Function(_$CommentDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment = null,
    Object? commentatorUsername = null,
    Object? commentatorUid = null,
    Object? commentatorEmail = null,
    Object? commentatorImageUrl = null,
    Object? commentedAt = null,
  }) {
    return _then(_$CommentDataImpl(
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      commentatorUsername: null == commentatorUsername
          ? _value.commentatorUsername
          : commentatorUsername // ignore: cast_nullable_to_non_nullable
              as String,
      commentatorUid: null == commentatorUid
          ? _value.commentatorUid
          : commentatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      commentatorEmail: null == commentatorEmail
          ? _value.commentatorEmail
          : commentatorEmail // ignore: cast_nullable_to_non_nullable
              as String,
      commentatorImageUrl: null == commentatorImageUrl
          ? _value.commentatorImageUrl
          : commentatorImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      commentedAt: null == commentedAt
          ? _value.commentedAt
          : commentedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentDataImpl implements _CommentData {
  const _$CommentDataImpl(
      {required this.comment,
      required this.commentatorUsername,
      required this.commentatorUid,
      required this.commentatorEmail,
      required this.commentatorImageUrl,
      @DateTimeTimestampConverter() required this.commentedAt});

  factory _$CommentDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentDataImplFromJson(json);

  @override
  final String comment;
  @override
  final String commentatorUsername;
  @override
  final String commentatorUid;
  @override
  final String commentatorEmail;
  @override
  final String commentatorImageUrl;
  @override
  @DateTimeTimestampConverter()
  final DateTime commentedAt;

  @override
  String toString() {
    return 'CommentData(comment: $comment, commentatorUsername: $commentatorUsername, commentatorUid: $commentatorUid, commentatorEmail: $commentatorEmail, commentatorImageUrl: $commentatorImageUrl, commentedAt: $commentedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentDataImpl &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.commentatorUsername, commentatorUsername) ||
                other.commentatorUsername == commentatorUsername) &&
            (identical(other.commentatorUid, commentatorUid) ||
                other.commentatorUid == commentatorUid) &&
            (identical(other.commentatorEmail, commentatorEmail) ||
                other.commentatorEmail == commentatorEmail) &&
            (identical(other.commentatorImageUrl, commentatorImageUrl) ||
                other.commentatorImageUrl == commentatorImageUrl) &&
            (identical(other.commentedAt, commentedAt) ||
                other.commentedAt == commentedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, comment, commentatorUsername,
      commentatorUid, commentatorEmail, commentatorImageUrl, commentedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentDataImplCopyWith<_$CommentDataImpl> get copyWith =>
      __$$CommentDataImplCopyWithImpl<_$CommentDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentDataImplToJson(
      this,
    );
  }
}

abstract class _CommentData implements CommentData {
  const factory _CommentData(
          {required final String comment,
          required final String commentatorUsername,
          required final String commentatorUid,
          required final String commentatorEmail,
          required final String commentatorImageUrl,
          @DateTimeTimestampConverter() required final DateTime commentedAt}) =
      _$CommentDataImpl;

  factory _CommentData.fromJson(Map<String, dynamic> json) =
      _$CommentDataImpl.fromJson;

  @override
  String get comment;
  @override
  String get commentatorUsername;
  @override
  String get commentatorUid;
  @override
  String get commentatorEmail;
  @override
  String get commentatorImageUrl;
  @override
  @DateTimeTimestampConverter()
  DateTime get commentedAt;
  @override
  @JsonKey(ignore: true)
  _$$CommentDataImplCopyWith<_$CommentDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
