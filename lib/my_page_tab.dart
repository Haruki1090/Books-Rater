import 'package:books_rater/controllers/auth_controller.dart';
import 'package:books_rater/controllers/user_data_controller.dart';
import 'package:books_rater/setting_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'editing_my_data.dart';

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

class MyPageTab extends ConsumerStatefulWidget {
  const MyPageTab({Key? key}) : super(key: key);

  @override
  ConsumerState<MyPageTab> createState() => _MyPageTabState();
}

class _MyPageTabState extends ConsumerState<MyPageTab> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataControllerNotifierProvider);
    final bookCount = ref.watch(bookCountProvider).asData?.value;

    if (userData == null) {
      return const Scaffold(
        body: Center(
          child: Text("ユーザーデータがありません。"),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
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
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Theme.of(context).brightness == Brightness.dark
                          ? Colors.white // ダークモードの時のボタンの背景色
                          : Colors.black; // ライトモードの時のボタンの背景色
                    }
                    return Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // ダークモードの時のボタンの背景色
                        : Colors.black; // ライトモードの時のボタンの背景色
                  },
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditingUserDataPage()),
                );
              },
              child: Text(
                'プロフィールを編集',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black // ダークモードの時のテキストカラー
                      : Colors.white, // ライトモードの時のテキストカラー
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

