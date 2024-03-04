import 'package:books_rater/date_time_timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_data.freezed.dart';
part 'book_data.g.dart';

@freezed
class BookData with _$BookData {
  const factory BookData({
    required String uid,
    required bool banned,
    required String email,
    required String bookId,
    required String title,
    required String bookImageUrl,
    required String description,
    required List favorites,
    @DateTimeTimestampConverter() required DateTime createdAt,
    @DateTimeTimestampConverter() required DateTime updatedAt,
  }) = _BookData;

  factory BookData.fromJson(Map<String, dynamic> json) => _$BookDataFromJson(json);
}