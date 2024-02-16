import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // ユーザー情報を取得
  Future<Map<String, dynamic>> getUserData(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection('users').doc(uid).get();
    return snapshot.data()!;
  }

}
