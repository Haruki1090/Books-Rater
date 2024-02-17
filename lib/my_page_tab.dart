import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPageTab extends StatelessWidget {
  const MyPageTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
      ),
      body: user != null ? FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user.email).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('ユーザーデータが見つかりません'));
          }

          final userData = snapshot.data?.data() as Map<String, dynamic>;
          final username = userData['username'] ?? '不明なユーザー';

          return Center(
            child: Text('こんにちは、$usernameさん', style: TextStyle(fontSize: 24)),
          );
        },
      ) : const Center(child: Text('ログインしていません')),
    );
  }
}
