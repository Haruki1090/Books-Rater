import 'dart:io';
import 'package:books_rater/book_data.dart';
import 'package:books_rater/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PostingNewBook extends ConsumerStatefulWidget {
  const PostingNewBook({Key? key}) : super(key: key);

  @override
  ConsumerState<PostingNewBook> createState() => _PostingNewBookState();
}

Future<void> callIncrementBookCount(
    {required String email}
    ) async {
  HttpsCallable callable = FirebaseFunctions.instanceFor(region: "us-central1").httpsCallable('incrementBookCount');
  try {
    print('投稿者：${email}');
    await callable.call(<String, dynamic>{
      'email': email,
    });
  } catch (e) {
    print(e);
  }
}

Future<void> addBookToUserBooks({
  required String title,
  required String description,
  required bool banned,
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
    uid: user.uid,
    email: user.email!,
    banned: banned,
    title: title,
    description: description,
    bookImageUrl: bookImageUrl,
    favoritesCount: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  // bookId 問題の解決
  final DocumentReference documentRef = FirebaseFirestore.instance.collection('users').doc(user.email).collection('books').doc();
  final bookId = documentRef.id;
  final _newBookData = newBookData.copyWith(bookId: bookId);
  await documentRef.set(_newBookData.toJson());
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
final bannedProvider = StateProvider<bool>((ref) => false);

class _PostingNewBookState extends ConsumerState<PostingNewBook> {
  File? _selectedBookImageFile;


  Future<void> _pickBookImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedBookImageFile = File(pickedFile.path); // 選択した画像ファイルを仮セット
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickBookImage,
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

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                    hintText: 'タイトルを入力してください',
                  ),
                  onChanged: (value) => ref.read(titleProvider.notifier).state = value,
                ),
                const SizedBox(height: 20.0),

                TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: '説明',
                    hintText: '説明を入力してください',
                  ),
                  onChanged: (value) => ref.read(descriptionProvider.notifier).state = value,
                ),
                const SizedBox(height: 20.0),

                // 公開設定
                ListTile(
                  title: const Text('ホーム非表示にする'),
                  leading: SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('ホーム非表示について'),
                              content: const Text('ホーム非表示にすると、他のユーザーがあなたの投稿した本を見ることができなくなります。ただし、あなた自身は自分の投稿した本を見ることができます。この設定は投稿した後からでも変更可能です。'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('閉じる'),
                                ),
                              ],
                            );
                          },
                        );

                      },
                    ),
                  ),
                  trailing: Consumer(
                    builder: (context, ref, _) {
                      final banned = ref.watch(bannedProvider);
                      return CupertinoSwitch(
                        value: banned,
                        onChanged: (bool value) {
                          ref.read(bannedProvider.notifier).state = value;
                        },
                      );
                    },
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (_selectedBookImageFile != null) {

                      final title = ref.read(titleProvider);
                      final description = ref.read(descriptionProvider);
                      final banned = ref.read(bannedProvider);

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(child: CircularProgressIndicator());
                        },
                      );

                      await addBookToUserBooks(
                        title: title,
                        description: description,
                        banned: banned,
                        imageFile: _selectedBookImageFile!,
                      );

                      await callIncrementBookCount(
                        email: FirebaseAuth.instance.currentUser!.email!,
                      );

                      Navigator.of(context).pop();

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