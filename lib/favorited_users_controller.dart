import 'package:books_rater/book_data.dart';
import 'package:books_rater/favorites_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'favorited_users_controller.g.dart';

@riverpod
class FavoritedUsersController extends _$FavoritedUsersController {
  @override
  Stream<List<FavoritesData>> build(BookData bookData) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(bookData.email) // 書籍の投稿者の email を使用
        .collection('books')
        .doc(bookData.bookId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      return FavoritesData.fromJson(doc.data());
    }).toList());
  }
}