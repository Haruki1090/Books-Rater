import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    required String uid, // ユーザーID(e-mail)
    required String email,
    required String username,
    required String imageUrl,
    required num bookCount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}
