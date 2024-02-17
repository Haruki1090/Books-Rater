import 'package:books_rater/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:books_rater/home.dart'; // StateNotifierProviderを定義している場所を参照

class EditingUserDataPage extends ConsumerStatefulWidget {
  const EditingUserDataPage({super.key});

  @override
  ConsumerState<EditingUserDataPage> createState() => _EditingUserDataPageState();
}

class _EditingUserDataPageState extends ConsumerState<EditingUserDataPage> {
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

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

  Future<void> _saveUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.email).update({
        'username': _usernameController.text,
        'updatedAt': DateTime.now(),
      });

      // StateNotifierを使用してユーザーデータの状態を更新
      ref.read(userDataProvider.notifier).updateUserData(_usernameController.text);

      print('ユーザー情報の変更を保存しました');
      Navigator.pop(context);
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
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
