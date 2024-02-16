// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Users _$UsersFromJson(Map<String, dynamic> json) {
  return _Users.fromJson(json);
}

/// @nodoc
mixin _$Users {
  String get uid => throw _privateConstructorUsedError; // ユーザーID(e-mail)
  String get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  num get bookCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<BookData> get books => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UsersCopyWith<Users> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersCopyWith<$Res> {
  factory $UsersCopyWith(Users value, $Res Function(Users) then) =
      _$UsersCopyWithImpl<$Res, Users>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String username,
      String imageUrl,
      num bookCount,
      DateTime createdAt,
      DateTime updatedAt,
      List<BookData> books});
}

/// @nodoc
class _$UsersCopyWithImpl<$Res, $Val extends Users>
    implements $UsersCopyWith<$Res> {
  _$UsersCopyWithImpl(this._value, this._then);

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
    Object? bookCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? books = null,
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
      bookCount: null == bookCount
          ? _value.bookCount
          : bookCount // ignore: cast_nullable_to_non_nullable
              as num,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      books: null == books
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<BookData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UsersImplCopyWith<$Res> implements $UsersCopyWith<$Res> {
  factory _$$UsersImplCopyWith(
          _$UsersImpl value, $Res Function(_$UsersImpl) then) =
      __$$UsersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String username,
      String imageUrl,
      num bookCount,
      DateTime createdAt,
      DateTime updatedAt,
      List<BookData> books});
}

/// @nodoc
class __$$UsersImplCopyWithImpl<$Res>
    extends _$UsersCopyWithImpl<$Res, _$UsersImpl>
    implements _$$UsersImplCopyWith<$Res> {
  __$$UsersImplCopyWithImpl(
      _$UsersImpl _value, $Res Function(_$UsersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? username = null,
    Object? imageUrl = null,
    Object? bookCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? books = null,
  }) {
    return _then(_$UsersImpl(
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
      bookCount: null == bookCount
          ? _value.bookCount
          : bookCount // ignore: cast_nullable_to_non_nullable
              as num,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<BookData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UsersImpl implements _Users {
  const _$UsersImpl(
      {required this.uid,
      required this.email,
      required this.username,
      required this.imageUrl,
      required this.bookCount,
      required this.createdAt,
      required this.updatedAt,
      required final List<BookData> books})
      : _books = books;

  factory _$UsersImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsersImplFromJson(json);

  @override
  final String uid;
// ユーザーID(e-mail)
  @override
  final String email;
  @override
  final String username;
  @override
  final String imageUrl;
  @override
  final num bookCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<BookData> _books;
  @override
  List<BookData> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  @override
  String toString() {
    return 'Users(uid: $uid, email: $email, username: $username, imageUrl: $imageUrl, bookCount: $bookCount, createdAt: $createdAt, updatedAt: $updatedAt, books: $books)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsersImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.bookCount, bookCount) ||
                other.bookCount == bookCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._books, _books));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      username,
      imageUrl,
      bookCount,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_books));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UsersImplCopyWith<_$UsersImpl> get copyWith =>
      __$$UsersImplCopyWithImpl<_$UsersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsersImplToJson(
      this,
    );
  }
}

abstract class _Users implements Users {
  const factory _Users(
      {required final String uid,
      required final String email,
      required final String username,
      required final String imageUrl,
      required final num bookCount,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final List<BookData> books}) = _$UsersImpl;

  factory _Users.fromJson(Map<String, dynamic> json) = _$UsersImpl.fromJson;

  @override
  String get uid;
  @override // ユーザーID(e-mail)
  String get email;
  @override
  String get username;
  @override
  String get imageUrl;
  @override
  num get bookCount;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<BookData> get books;
  @override
  @JsonKey(ignore: true)
  _$$UsersImplCopyWith<_$UsersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
