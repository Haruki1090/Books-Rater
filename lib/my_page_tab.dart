import 'package:books_rater/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_data.dart';
import 'editing_my_data.dart';

class MyPageTab extends ConsumerStatefulWidget {
  const MyPageTab({Key? key}) : super(key: key);

  @override
  ConsumerState<MyPageTab> createState() => _MyPageTabState();
}

class _MyPageTabState extends ConsumerState<MyPageTab> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);

    if (userData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(userData.imageUrl, height: 100),
            ),
            Text(userData.username, style: const TextStyle(fontSize: 24)),
            Text('登録した本：${userData.bookCount}冊', style: const TextStyle(fontSize: 20)),
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

