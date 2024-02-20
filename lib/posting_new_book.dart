import 'dart:io';
import 'package:books_rater/book_data.dart';
import 'package:books_rater/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PostingNewBook extends ConsumerStatefulWidget {
  const PostingNewBook({Key? key}) : super(key: key);

  @override
  ConsumerState<PostingNewBook> createState() => _PostingNewBookState();
}

Future<void> addBookToUserAllUserBooks({
  required String title,
  required String description,
  required File imageFile,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('User not logged in');
  }

  // 画像をStorageにアップロードし、URLを取得
  String bookImageUrl = await uploadImage(imageFile);

  // 新しい本のデータを作成
  final newBookData = BookData(
    bookId: '',
    uid: user.uid, // 投稿したユーザーのUID、必要に応じて
    banned: false, // bannedフラグの初期値、必要に応じて
    title: title,
    description: description,
    bookImageUrl: bookImageUrl,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );


  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('books')
      .add(newBookData.toJson());
}




Future<String> uploadImage(File imageFile) async {
  final storageRef = FirebaseStorage.instance.ref();
  final imagesRef = storageRef.child("images/${DateTime.now().toIso8601String()}.jpg");
  UploadTask uploadTask = imagesRef.putFile(imageFile);

  // アップロードが完了するのを待つ
  await uploadTask.whenComplete(() => null);
  // アップロードされたファイルのURLを取得
  String imageUrl = await imagesRef.getDownloadURL();
  return imageUrl;
}

final titleProvider = StateProvider<String>((ref) => '');
final bookUrlProvider = StateProvider<String>((ref) => '');
final descriptionProvider = StateProvider<String>((ref) => '');

class _PostingNewBookState extends ConsumerState<PostingNewBook> {
  File? _selectedBookImageFile;


  Future<void> _pickBookImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedBookImageFile = File(pickedFile.path); // 選択した画像ファイルをセット
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "本の登録",
            style: TextStyle(fontSize: 25.0),
            textAlign: TextAlign.center,
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickBookImage, // 画像選択ダイアログを開く
                  child: Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: _selectedBookImageFile != null
                        ? Image.file(_selectedBookImageFile!, fit: BoxFit.cover)
                        : const Icon(Icons.image_outlined, size: 50.0), // デフォルト -> アイコンを表示
                  ),
                ),
                const SizedBox(height: 20.0),
                ///タイトル
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                    hintText: 'タイトルを入力してください',
                  ),
                  onChanged: (value) => ref.read(titleProvider.notifier).state = value,
                ),
                const SizedBox(height: 20.0),
                ///URL
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '本のURL',
                    hintText: '本のURLを入力してください',
                  ),
                  onChanged: (value) => ref.read(bookUrlProvider.notifier).state = value,
                ),
                const SizedBox(height: 20.0),
                ///説明
                TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: '説明',
                    hintText: '説明を入力してください',
                  ),
                  onChanged: (value) => ref.read(descriptionProvider.notifier).state = value,
                ),
                const SizedBox(height: 20.0),

                ElevatedButton(
                  onPressed: () async {
                    if (_selectedBookImageFile != null) {

                      final title = ref.read(titleProvider);
                      final description = ref.read(descriptionProvider);

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(child: CircularProgressIndicator());
                        },
                      );

                      await addBookToUserAllUserBooks(
                        title: title,
                        description: description,
                        imageFile: _selectedBookImageFile!,
                      );

                      Navigator.of(context).pop(); // プログレスダイアログを閉じる

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('投稿に成功しました'),
                          backgroundColor: Colors.greenAccent,
                          duration: Duration(seconds: 2),
                        ),
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                            (Route<dynamic> route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('画像を選択してください'),
                          backgroundColor: Colors.orange,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text('投稿'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}