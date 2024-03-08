import 'dart:async';
import 'package:books_rater/book_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'favorites_count_controller.g.dart';

@riverpod
class FavoritesCountControllerNotifier extends _$FavoritesCountControllerNotifier {
  @override
  Stream<int> build(BookData bookData) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(bookData.email) // 書籍の投稿者の email を使用
        .collection('books')
        .doc(bookData.bookId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs.length); // いいねの数をカウント
  }
}
