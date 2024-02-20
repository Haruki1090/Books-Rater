import 'package:books_rater/book_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostingNewBook extends ConsumerStatefulWidget {
  const PostingNewBook({Key? key}) : super(key: key);

  @override
  ConsumerState<PostingNewBook> createState() => _PostingNewBookState();
}

Future<void> saveOrUpdateBook(BookData bookData) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('User not logged in');
  }

  final booksCollection = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('books');

  // Firestoreに保存するためにBookDataをJSON形式に変換
  final bookDataJson = bookData.toJson();

  if (bookData.bookId.isEmpty) {
    // bookIdがnullまたは空の場合、新しい本のデータを追加
    final docRef = await booksCollection.add(bookDataJson);
    // 必要に応じて、新しく生成されたドキュメントIDを使用して何らかの処理を行う
  } else {
    // bookIdが存在する場合、既存の本のデータを更新
    await booksCollection.doc(bookData.bookId).update(bookDataJson);
  }
}

final titleProvider = StateProvider<String>((ref) => '');
final bookUrlProvider = StateProvider<String>((ref) => '');
final descriptionProvider = StateProvider<String>((ref) => '');

class _PostingNewBookState extends ConsumerState<PostingNewBook> {
  @override
  Widget build(BuildContext context) {

    final title = ref.watch(titleProvider);
    final bookUrl = ref.watch(bookUrlProvider);
    final description = ref.watch(descriptionProvider);

    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              "本の登録",
              style: TextStyle(
                fontSize: 25.0,
              ),
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
                ///本の画像
                GestureDetector(
                  onTap: (){
                    print('画像変更ボタンが押されました');
                  },
                  child: Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(Icons.image_outlined, size: 50.0),
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
                    final newBookData = BookData(
                      bookId: '',
                      title: ref.read(titleProvider),
                      bookImageUrl: ref.read(bookUrlProvider),
                      description: ref.read(descriptionProvider),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );

                    await saveOrUpdateBook(newBookData);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('投稿に成功しました'),
                        action: SnackBarAction(
                          label: 'アクション',
                          textColor: Colors.greenAccent,
                          onPressed: () {
                            // アクションボタンタップ時の処理
                            // 今投稿したものを表示する
                          },
                        ),
                        backgroundColor: Colors.orange,
                        duration: const Duration(seconds: 2),
                      ),
                    );
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