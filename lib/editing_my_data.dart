import 'dart:io';
import 'package:books_rater/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class EditingUserDataPage extends ConsumerStatefulWidget {
  const EditingUserDataPage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditingUserDataPage> createState() => _EditingUserDataPageState();
}

class _EditingUserDataPageState extends ConsumerState<EditingUserDataPage> {
  final _usernameController = TextEditingController();
  String? _imageUrl;

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
      final imageUrl = userData.data()?['imageUrl'] as String?;
      if (username != null) {
        _usernameController.text = username;
      }
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  Future<void> _saveUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final newUsername = _usernameController.text;
      await FirebaseFirestore.instance.collection('users').doc(user.email).update({
        'username': newUsername,
        'updatedAt': DateTime.now(),
      });
      print('ユーザー情報の変更を保存しました');

      // UserStateNotifierのstateを更新
      ref.read(userDataProvider.notifier).updateUserData(newUsername, imageUrl: _imageUrl);

      Navigator.pop(context);
    }
  }


  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File file = File(pickedFile.path);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final storageRef = FirebaseStorage.instance.ref('userImages/${user.uid}/${Timestamp.now().millisecondsSinceEpoch}');
        // プログレスインジケータを表示
        showDialog(
          context: context,
          barrierDismissible: false, // ユーザーがダイアログ外をタップしても閉じないようにする
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
        try {
          await storageRef.putFile(file);
          final imageUrl = await storageRef.getDownloadURL();
          setState(() {
            _imageUrl = imageUrl;
          });
          // Firestoreに画像URLを保存
          await FirebaseFirestore.instance.collection('users').doc(user.email).update({
            'imageUrl': imageUrl,
          });
          // UserStateNotifierのstateを更新
          ref.read(userDataProvider.notifier).updateUserData(_usernameController.text, imageUrl: imageUrl);
        } catch (e) {
          print("Error uploading image to Firebase Storage: $e");
        }
        // ダイアログを閉じる
        Navigator.of(context).pop();
      }
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageUrl != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(_imageUrl!, height: 100, fit: BoxFit.cover),
              ),
            ElevatedButton(
              onPressed: _pickAndUploadImage,
              child: const Text('プロフィール画像を変更'),
            ),
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
              onPressed: _saveUserData,
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
