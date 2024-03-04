import 'package:books_rater/date_time_timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_data.freezed.dart';
part 'comment_data.g.dart';

@freezed
class CommentData with _$CommentData {
  const factory CommentData({
    required String comment,
    required String commentator,
    @DateTimeTimestampConverter() required DateTime commentedAt,
  }) = _CommentData;

  factory CommentData.fromJson(Map<String, dynamic> json) => _$CommentDataFromJson(json);
}