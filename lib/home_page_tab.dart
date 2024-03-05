import 'package:books_rater/book_data.dart';
import 'package:books_rater/favorites_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomePageTab extends ConsumerStatefulWidget {
  const HomePageTab({Key? key}) : super(key: key);

  @override
  _HomePageTabState createState() => _HomePageTabState();
}

final allUsersBooksProvider = StreamProvider.autoDispose<List<BookData>>((ref) {
  return FirebaseFirestore.instance
      .collection("allUsersBooks")
      .where('banned', isEqualTo: false)
      .snapshots()
      .map((snapshot) {
    final books = snapshot.docs.map((e) {
      final bookData = BookData.fromJson(e.data());
      // デバッグコンソール出力
      print('Book: ${bookData.title}, Banned: ${bookData.banned}');
      return bookData;
    }).toList();
    return books;
  });
});

final favoritesCountProvider = StreamProvider.family<int, String>((ref, bookId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('books')
      .doc(bookId)
      .collection('favorites')
      .snapshots()
      .map((snapshot) => snapshot.docs.length); // いいねの数をカウント
});

final favoritesProvider = StreamProvider.family<bool, String>((ref, bookId) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return const Stream.empty();

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('books')
      .doc(bookId)
      .collection('favorites')
      .doc(user.uid)
      .snapshots()
      .map((snapshot) => snapshot.exists);
});


class _HomePageTabState extends ConsumerState<HomePageTab> {
  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(allUsersBooksProvider);
    return Scaffold(
      body: booksData.when(
        data: (books) {
          if (books.isEmpty) {
            return Center(child: Text('本が追加されていません'));
          } else {
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(book.title),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Image(image: NetworkImage(book.bookImageUrl))
                                ),
                              ),
                              SizedBox(height: 8),
                              Text('作成日: ${DateFormat('yyyy-MM-dd HH:mm').format(book.createdAt)}'),
                              SizedBox(height: 8),
                              Text(book.description),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.favorite)
                                      ),
                                      TextButton(
                                          onPressed: (){
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    padding: EdgeInsets.all(16),
                                                    width: MediaQuery.sizeOf(context).width,
                                                    height: MediaQuery.sizeOf(context).height*0.85,
                                                    child: Column(
                                                      children: [
                                                        Text(ref.watch(favoritesCountProvider(book.bookId)).when(
                                                          data: (count) => count.toString(),
                                                          loading: () => 'Loading...',
                                                          error: (error, _) => 'Error',
                                                        )),
                                                        SizedBox(height: 16),
                                                        // いいねしたユーザーをListViewで表示
                                                        //Expanded(child: ListView.builder(),),
                                                      ],
                                                    ),
                                                  );
                                                }
                                            );
                                          },
                                          child: Text(ref.watch(favoritesCountProvider(book.bookId)).when(
                                            data: (count) => count.toString(),
                                            loading: () => 'Loading...',
                                            error: (error, _) => 'Error',
                                          )),

                                      )
                                    ],
                                  ),
                                  SizedBox(width: 16),
                                  Text('コメント数: 0'),
                                ],
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('閉じる'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('users').doc(book.email).get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        // データが存在する場合、ユーザーデータを取得
                        final userData = snapshot.data!.data() as Map<String, dynamic>?;
                        final userName = userData?['username'] ?? '不明';
                        final userImageUrl = userData?['imageUrl'] ?? 'デフォルト画像URL';
                        return Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(userImageUrl),
                                              radius: 20,
                                            ),
                                          ),
                                          Text(userName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Text(
                                          book.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                      ),
                                      SizedBox(height: 8),
                                      Text("作成日: ${DateFormat('yyyy-MM-dd HH:mm').format(book.createdAt)}"),
                                      SizedBox(height: 8),
                                      Text(
                                        book.description,
                                        maxLines: 4,
                                      ),
                                      Row(
                                          children: [
                                            Consumer(builder: (context, ref, _) {
                                              final isFavorite = ref.watch(favoritesProvider(book.bookId)).asData?.value ?? false;
                                            return IconButton(
                                              icon: Icon(
                                                Icons.favorite,
                                                color: isFavorite ? Colors.red : Colors.grey,
                                              ),
                                              onPressed: () async{
                                                // いいねボタンの onPressed コールバック内
                                                final user = FirebaseAuth.instance.currentUser;
                                                if (user == null) return; // ユーザーがログインしていない場合は何もしない

                                                final favoritesRef = FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(book.email)
                                                    .collection('books')
                                                    .doc(book.bookId)
                                                    .collection('favorites')
                                                    .doc(user.uid);

                                                final favoriteDocSnapshot = await favoritesRef.get();

                                                if (favoriteDocSnapshot.exists) {
                                                  // 既にいいねしている場合は、そのドキュメント（いいね）を削除
                                                  await favoritesRef.delete();
                                                } else {
                                                  // いいねしていない場合は、新しいドキュメントを追加
                                                  final favoritesData = FavoritesData(
                                                    uid: user.uid,
                                                    email: user.email ?? '',
                                                    username: userName ?? '',
                                                    imageUrl: userImageUrl ?? '',
                                                    createdAt: DateTime.now(),
                                                  );
                                                  await favoritesRef.set(favoritesData.toJson());
                                                }

                                              },
                                            );
                                            }),
                                            Text(ref.watch(favoritesCountProvider(book.bookId)).when(
                                              data: (count) => count.toString(),
                                              loading: () => 'Loading...',
                                              error: (error, _) => 'Error',
                                            )),

                                            IconButton(
                                              icon: Icon(Icons.comment),
                                              onPressed: () {
                                                // コメントボタンが押された時の処理
                                              },
                                            ),
                                            Text('コメント数'),
                                          ]
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(book.bookImageUrl, width: 120, height: 180, fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // データロード中またはエラーがある場合
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                );
              },

            );

          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
