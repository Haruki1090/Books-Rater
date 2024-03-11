import 'package:books_rater/controllers/book_count_controller.dart';
import 'package:books_rater/controllers/user_data_controller.dart';
import 'package:books_rater/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'editing_my_data.dart';

class MyPageTab extends ConsumerStatefulWidget {
  const MyPageTab({Key? key}) : super(key: key);

  @override
  ConsumerState<MyPageTab> createState() => _MyPageTabState();
}

class _MyPageTabState extends ConsumerState<MyPageTab> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataControllerNotifierProvider);
    final bookCount = ref.watch(bookCountControllerNotifierProvider as ProviderListenable).asData?.value;

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

