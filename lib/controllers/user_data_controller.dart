import 'package:books_rater/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDataControllerNotifier extends StateNotifier<UserData?> {
  UserDataControllerNotifier() : super(null) {
    _loadUserData();
  }

  void resetUserData() {
    state = null;
  }

  void reloadUserData() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      final userDataDoc = await FirebaseFirestore.instance.collection('users').doc(user.email).get();
      final userData = userDataDoc.data();
      if (userData != null) {
        state = UserData(
          uid: user.uid,
          email: user.email!,
          username: userData['username'] ?? '',
          imageUrl: userData['imageUrl'] ?? '',
          bookCount: userData['bookCount'] ?? 0,
          createdAt: (userData['createdAt'] as Timestamp).toDate(),
          updatedAt: (userData['updatedAt'] as Timestamp).toDate(),
        );
      }
    } catch (e) {
      throw Exception('Error loading user data: $e');
    }
  }

  Future<void> updateUserData(String username, {String? imageUrl}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      Map<String, dynamic> updates = {'username': username, 'updatedAt': DateTime.now()};
      if (imageUrl != null) updates['imageUrl'] = imageUrl;

      // Firestoreのユーザーデータを更新
      await FirebaseFirestore.instance.collection('users').doc(user.email).update(updates);

      // 現在のstateを取得し、nullでない場合のみ新しい値で更新する
      UserData? currentState = state;
      if (currentState != null) {
        // 新しい値でstateを更新
        UserData updatedState = currentState.copyWith(
          username: username,
          imageUrl: imageUrl ?? currentState.imageUrl, // imageUrlがnullなら現在の値を保持
          updatedAt: DateTime.now(),
        );
        state = updatedState; // StateNotifierのstateを更新
      }
    } catch (e) {
      throw Exception('Error updating user data: $e');
    }
  }
}

final userDataControllerNotifierProvider = StateNotifierProvider<UserDataControllerNotifier, UserData?>((ref) {
  return UserDataControllerNotifier();
});
