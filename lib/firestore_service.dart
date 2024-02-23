import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore _myBooksDb = FirebaseFirestore.instance;

  Future<int> countBooks(String userId) async {
    final userBooksCollection = _myBooksDb.collection('users').doc(userId).collection('books');
    final querySnapshot = await userBooksCollection.get();
    return querySnapshot.docs.length;
  }

}