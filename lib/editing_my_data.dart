import 'dart:io';
import 'package:books_rater/controllers/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:books_rater/home.dart';

class EditingUserDataPage extends ConsumerStatefulWidget {
  const EditingUserDataPage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditingUserDataPage> createState() => _EditingUserDataPageState();
}

class _EditingUserDataPageState extends ConsumerState<EditingUserDataPage> {
  final _usernameController = TextEditingController();
  String? _imageUrl; // Firestoreから読み込んだ現在の画像URL
  File? _selectedUserImageFile; // ユーザーが選択した新しい画像ファイル

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
      String? imageUrl = _imageUrl;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      Future<void> uploadImageIfNeeded() async {
        if (_selectedUserImageFile != null) {
          final storageRef = FirebaseStorage.instance.ref('userImages/${user.uid}/${Timestamp.now().millisecondsSinceEpoch}');
          await storageRef.putFile(_selectedUserImageFile!);
          imageUrl = await storageRef.getDownloadURL();
        }
      }

      uploadImageIfNeeded().then((_) {
        return FirebaseFirestore.instance.collection('users').doc(user.email).update({
          'username': _usernameController.text,
          'imageUrl': imageUrl,
          'updatedAt': DateTime.now(),
        });
      }).then((_) {
        ref.read(userDataControllerNotifierProvider.notifier).updateUserData(_usernameController.text, imageUrl: imageUrl);
      }).then((_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ユーザー情報を更新しました')),
        );
      }).then((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
              (Route<dynamic> route) => false,
        );
      }).catchError((error) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ユーザー情報の更新に失敗しました: $error')),
        );
      });
    }
  }


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedUserImageFile = File(pickedFile.path); // 選択した画像ファイルを仮セット
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_selectedUserImageFile != null)
                  Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(_selectedUserImageFile!)
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
                const SizedBox(height: 15),
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
                  onPressed: _pickImage,
                  child: Text(
                    'プロフィール画像を変更',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black // ダークモードの時のテキストカラー
                          : Colors.white, // ライトモードの時のテキストカラー
                    ),
                  ),
                ),
              ]
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
              onPressed: _saveUserData,
              child: Text(
                '保存',
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
