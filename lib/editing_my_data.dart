import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:books_rater/home.dart'; // home.dartが適切に設定されている必要があります

class EditingUserDataPage extends ConsumerStatefulWidget {
  const EditingUserDataPage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditingUserDataPage> createState() => _EditingUserDataPageState();
}

class _EditingUserDataPageState extends ConsumerState<EditingUserDataPage> {
  final _usernameController = TextEditingController();
  String? _imageUrl; // Firestoreから読み込んだ現在の画像URL
  File? _selectedFile; // ユーザーが選択した新しい画像ファイル

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
      String? imageUrl = _imageUrl; // 保存する画像URL

      showDialog(
        context: context,
        barrierDismissible: false, // ユーザーがダイアログ外をタップしても閉じないようにする
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      // 新しい画像が選択されていればアップロード
      if (_selectedFile != null) {
        final storageRef = FirebaseStorage.instance.ref('userImages/${user.uid}/${Timestamp.now().millisecondsSinceEpoch}');
        await storageRef.putFile(_selectedFile!);
        imageUrl = await storageRef.getDownloadURL(); // 新しい画像URLを取得
      }

      // Firestoreにユーザーデータを更新
      await FirebaseFirestore.instance.collection('users').doc(user.email).update({
        'username': _usernameController.text,
        'imageUrl': imageUrl,
        'updatedAt': DateTime.now(),
      });

      // 更新後のユーザーデータでstateを更新
      ref.read(userDataProvider.notifier).updateUserData(_usernameController.text, imageUrl: imageUrl);

      Navigator.of(context).pop();


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ユーザー情報を更新しました')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  Home()),
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path); // 選択した画像ファイルをセット
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_selectedFile != null)
                    Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(_selectedFile!)
                            )
                        )
                    )
                  else if (_imageUrl != null)
                    Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(_imageUrl!)
                            )
                        )
                    )
                  else
                    const Icon(Icons.account_circle, size: 200),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _pickImage, // 画像選択ダイアログを開く
                    child: const Text('プロフィール画像を変更'),
                  ),
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'ユーザー名',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _saveUserData, // データ保存処理を実行
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
