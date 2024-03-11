import 'package:books_rater/book_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'my_books_controller.g.dart';

@riverpod
class MyBooksControllerNotifier extends _$MyBooksControllerNotifier {
  @override
  Stream<List<BookData>> build(User userCredential) {
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.email)
        .collection('books');
    final stream = collection.snapshots().map(
            (e) => e.docs.map((e) => BookData.fromJson(e.data())).toList()
    );
    return stream;
    }
}