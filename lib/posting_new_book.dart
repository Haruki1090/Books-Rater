import 'dart:io';
import 'package:books_rater/book_data.dart';
import 'package:books_rater/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PostingNewBook extends ConsumerStatefulWidget {
  const PostingNewBook({Key? key}) : super(key: key);

  @override
  ConsumerState<PostingNewBook> createState() => _PostingNewBookState();
}

Future<void> saveOrUpdateBook(BookData bookData, File imageFile) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('User not logged in');
  }

  // 画像をStorageにアップロードし、URLを取得
  String bookImageUrl = await uploadImage(imageFile);

  // BookDataオブジェクトを更新して、画像URLを含める
  final updatedBookData = bookData.copyWith(bookImageUrl: bookImageUrl);

  final booksCollection = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('books');

  // Firestoreに保存するためにBookDataをJSON形式に変換
  final bookDataJson = updatedBookData.toJson();

  // 新しい本を追加するか、既存の本を更新する
  if (updatedBookData.bookId.isEmpty) {
    // bookIdが空の場合、新しい本のデータを追加し、自動生成されたIDを取得
    final docRef = await booksCollection.add(bookDataJson);
    // 必要に応じて、docRefを使用して何か処理を行う（例：自動生成されたIDを保存する）
  } else {
    // bookIdが存在する場合、既存の本のデータを更新
    await booksCollection.doc(updatedBookData.bookId).update(bookDataJson);
  }
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
          Text(
            "本の登録",
            style: TextStyle(fontSize: 25.0),
            textAlign: TextAlign.center,
          ),
          IconButton(
            icon: Icon(Icons.close),
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
                        : Icon(Icons.image_outlined, size: 50.0), // デフォルト -> アイコンを表示
                  ),
                ),
                SizedBox(height: 20.0),
                ///タイトル
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'タイトル',
                    hintText: 'タイトルを入力してください',
                  ),
                  onChanged: (value) => ref.read(titleProvider.notifier).state = value,
                ),
                SizedBox(height: 20.0),
                ///URL
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '本のURL',
                    hintText: '本のURLを入力してください',
                  ),
                  onChanged: (value) => ref.read(bookUrlProvider.notifier).state = value,
                ),
                SizedBox(height: 20.0),
                ///説明
                TextFormField(
                  maxLines: null,///改行入力可能
                  decoration: InputDecoration(
                    labelText: '説明',
                    hintText: '説明を入力してください',
                  ),
                  onChanged: (value) => ref.read(descriptionProvider.notifier).state = value,
                ),
                SizedBox(height: 20.0),
                ///投稿ボタン
                ElevatedButton(
                  onPressed: () async{
                    if(_selectedBookImageFile != null) {
                      final newBookData = BookData(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        bookId: '',
                        title: ref.read(titleProvider),
                        bookImageUrl: '',
                        description: ref.read(descriptionProvider),
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        banned: false,
                      );

                      await saveOrUpdateBook(newBookData, _selectedBookImageFile!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('投稿に成功しました'),
                          backgroundColor: Colors.greenAccent,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>  Home()),
                            (Route<dynamic> route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('エラーが発生しました'),
                          backgroundColor: Colors.orange,
                          duration: const Duration(seconds: 2),
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