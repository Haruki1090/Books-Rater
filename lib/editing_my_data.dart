import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EdditingUserDataPage extends ConsumerStatefulWidget {
  const EdditingUserDataPage({super.key});

  @override
  ConsumerState<EdditingUserDataPage> createState() => _EdditingUserDataPageState();
}

class _EdditingUserDataPageState extends ConsumerState<EdditingUserDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー情報編集'),
      ),
      body: Center(
        child: Column(
          // userImageの編集
          // usernameの編集
          // 保存ボタン
        )
      ),
    );
  }
}
