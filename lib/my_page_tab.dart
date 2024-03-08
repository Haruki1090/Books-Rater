import 'package:books_rater/controllers/auth_controller.dart';
import 'package:books_rater/home.dart';
import 'package:books_rater/setting_page.dart';
import 'package:books_rater/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'editing_my_data.dart';

class MyPageTab extends ConsumerStatefulWidget {
  const MyPageTab({Key? key}) : super(key: key);

  @override
  ConsumerState<MyPageTab> createState() => _MyPageTabState();
}

final bookCountProvider = StreamProvider.autoDispose<int>((ref) {
  final userCredential = ref.watch(authControllerNotifierProvider);
  if (userCredential == null) {
    throw Exception('User not logged in');
  } else {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.email)
        .snapshots()
        .map((snapshot) => snapshot.data()?['bookCount'] ?? 0);
  }
});

class _MyPageTabState extends ConsumerState<MyPageTab> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    final bookCount = ref.watch(bookCountProvider).asData?.value;

    if (userData == null) {
      return const Scaffold(
        body: Center(
          child: Text("ユーザーデータがありません。"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage()));
          }, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(userData.imageUrl)
                  ),
                ),
              ),
            ),
            Text(userData.username, style: const TextStyle(fontSize: 24)),
            Text('登録した本：${bookCount ?? 0}冊', style: const TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditingUserDataPage()),
                );
              },
              child: const Text('プロフィールを編集'),
            ),
          ],
        ),
      ),
    );
  }
}

