// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookData _$BookDataFromJson(Map<String, dynamic> json) {
  return _BookData.fromJson(json);
}

/// @nodoc
mixin _$BookData {
  String get bookId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookDataCopyWith<BookData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookDataCopyWith<$Res> {
  factory $BookDataCopyWith(BookData value, $Res Function(BookData) then) =
      _$BookDataCopyWithImpl<$Res, BookData>;
  @useResult
  $Res call(
      {String bookId,
      String title,
      String imageUrl,
      String description,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$BookDataCopyWithImpl<$Res, $Val extends BookData>
    implements $BookDataCopyWith<$Res> {
  _$BookDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? description = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookDataImplCopyWith<$Res>
    implements $BookDataCopyWith<$Res> {
  factory _$$BookDataImplCopyWith(
          _$BookDataImpl value, $Res Function(_$BookDataImpl) then) =
      __$$BookDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String bookId,
      String title,
      String imageUrl,
      String description,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$BookDataImplCopyWithImpl<$Res>
    extends _$BookDataCopyWithImpl<$Res, _$BookDataImpl>
    implements _$$BookDataImplCopyWith<$Res> {
  __$$BookDataImplCopyWithImpl(
      _$BookDataImpl _value, $Res Function(_$BookDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? description = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$BookDataImpl(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookDataImpl implements _BookData {
  const _$BookDataImpl(
      {required this.bookId,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.createdAt,
      required this.updatedAt});

  factory _$BookDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookDataImplFromJson(json);

  @override
  final String bookId;
  @override
  final String title;
  @override
  final String imageUrl;
  @override
  final String description;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'BookData(bookId: $bookId, title: $title, imageUrl: $imageUrl, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookDataImpl &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, bookId, title, imageUrl, description, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookDataImplCopyWith<_$BookDataImpl> get copyWith =>
      __$$BookDataImplCopyWithImpl<_$BookDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookDataImplToJson(
      this,
    );
  }
}

abstract class _BookData implements BookData {
  const factory _BookData(
      {required final String bookId,
      required final String title,
      required final String imageUrl,
      required final String description,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$BookDataImpl;

  factory _BookData.fromJson(Map<String, dynamic> json) =
      _$BookDataImpl.fromJson;

  @override
  String get bookId;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  String get description;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$BookDataImplCopyWith<_$BookDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
