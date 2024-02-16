import 'package:books_rater/book_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'users.freezed.dart';
part 'users.g.dart';

@freezed
class Users with _$Users {
  const factory Users({
    required String uid, // ユーザーID(e-mail)
    required String email,
    required String name,
    required num bookCount,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<BookData> books,
  }) = _Users;

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
}
