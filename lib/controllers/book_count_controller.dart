import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'book_count_controller.g.dart';

@riverpod
class BookCountControllerNotifier extends _$BookCountControllerNotifier {
  @override
  Stream<int> build(User userCredential) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.email)
        .snapshots()
        .map((snapshot) => snapshot.data()?['bookCount'] ?? 0);
    }
}