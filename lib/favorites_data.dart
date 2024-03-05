import 'package:books_rater/date_time_timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_data.freezed.dart';
part 'favorites_data.g.dart';

@freezed
class FavoritesData with _$FavoritesData {
  const factory FavoritesData({
    required String uid,
    required String email,
    required String username,
    required String imageUrl,
    @DateTimeTimestampConverter() required DateTime createdAt,
  }) = _FavoritesData;

  factory FavoritesData.fromJson(Map<String, dynamic> json) => _$FavoritesDataFromJson(json);
}