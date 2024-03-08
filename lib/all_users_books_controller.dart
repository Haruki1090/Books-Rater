import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'book_data.dart';

part 'all_users_books_controller.g.dart';

@riverpod
class AllUsersBooksControllerNotifier extends _$AllUsersBooksControllerNotifier {
  @override
  Stream<List<BookData>> build() {
    return FirebaseFirestore.instance
        .collection("allUsersBooks")
        .where('banned', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      final books = snapshot.docs.map((e) {
        final bookData = BookData.fromJson(e.data());
        return bookData;
      }).toList();
      return books;
    });
  }
}