import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EdditingUserDataPage extends ConsumerStatefulWidget {
  const EdditingUserDataPage({super.key});

  @override
  ConsumerState<EdditingUserDataPage> createState() => _EdditingUserDataPageState();
}

class _EdditingUserDataPageState extends ConsumerState<EdditingUserDataPage> {
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // ユーザー情報を読み込む(初期表示で起動)
  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.email).get();
      final username = userData.data()?['username'] as String?;
      if (username != null) {
        _usernameController.text = username;
      }
    }
  }

  // ユーザー情報を保存する(保存ボタンで起動)
  Future<void> _saveUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.email).update({
        'username': _usernameController.text,
        'updatedAt': DateTime.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー情報編集'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'ユーザー名',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _saveUserData();
                Navigator.pop(context);
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
