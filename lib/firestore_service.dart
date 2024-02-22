import 'package:books_rater/book_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final FirebaseFirestore _myBooksDb = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Stream<List<BookData>> getMyBooksData(){
    try {
      return _myBooksDb
          .collection('users')
          .doc(user!.email)
          .collection('books')
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => BookData.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      print('Error getting todoList: $e');
      throw e;
    }
  }

  Future<int> countBooks(String userId) async {
    final userBooksCollection = _myBooksDb.collection('users').doc(userId).collection('books');
    final querySnapshot = await userBooksCollection.get();
    return querySnapshot.docs.length;
  }

}