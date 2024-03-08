import 'package:books_rater/book_data.dart';
import 'package:books_rater/comment_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'comments_data_controller.g.dart';

@riverpod
class CommentsDataControllerNotifier extends _$CommentsDataControllerNotifier {
  @override
  Stream<List<CommentData>> build(BookData bookData) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(bookData.email) // 書籍の投稿者の email を使用
        .collection('books')
        .doc(bookData.bookId)
        .collection('comments')
        .orderBy('commentedAt', descending: true) // 最新のコメントが上に来るように
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => CommentData.fromJson(doc.data())).toList();
    });
  }
}