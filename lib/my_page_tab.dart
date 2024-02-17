import 'package:books_rater/editing_my_data.dart';
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
          final userImage = userData['imageUrl'] ?? 'https://www.shoshinsha-design.com/wp-content/uploads/2020/05/noimage-760x460.png';
          final username = userData['username'] ?? 'ゲスト';
          final bookCount = userData['bookCount'] ?? '取得中';

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 20, 90, 20),
                child: Image.network(userImage),
              ),
              const SizedBox(height: 16),
              Text('$username', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              TextButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EdditingUserDataPage()
                    )
                );
              }, child: const Text('プロフィールを編集')),
              const SizedBox(height: 16),
              Text('登録した本：$bookCount冊', style: TextStyle(fontSize: 20)),
            ],
          );
        },
      ) : const Center(child: Text('ログインしていません')),
    );
  }
}
