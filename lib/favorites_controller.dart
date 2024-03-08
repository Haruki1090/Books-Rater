import 'dart:async';
import 'package:books_rater/book_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'favorites_controller.g.dart';

// いいねの true/false を返す (いいね数やtrue人ではない)

@riverpod
class FavoritesControllerNotifier extends _$FavoritesControllerNotifier {
  @override
  Stream<bool> build(BookData bookData) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value(false);
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(bookData.email) // 投稿者の email を使用
        .collection('books')
        .doc(bookData.bookId)
        .collection('favorites')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) => snapshot.exists);
  }
}