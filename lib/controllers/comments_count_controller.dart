import 'package:books_rater/book_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'comments_count_controller.g.dart';

@riverpod
class CommentsCountControllerNotifier extends _$CommentsCountControllerNotifier {
  @override
  Stream<int> build(BookData bookData) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(bookData.email) // 書籍の投稿者の email を使用
        .collection('books')
        .doc(bookData.bookId)
        .collection('comments')
        .snapshots()
        .map((snapshot) => snapshot.docs.length); // コメントの数をカウント
  }
}
