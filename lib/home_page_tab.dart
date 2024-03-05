import 'package:books_rater/book_data.dart';
import 'package:books_rater/comment_data.dart';
import 'package:books_rater/favorites_data.dart';
import 'package:books_rater/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomePageTab extends ConsumerStatefulWidget {
  const HomePageTab({Key? key}) : super(key: key);

  @override
  HomePageTabState createState() => HomePageTabState();
}

final allUsersBooksProvider = StreamProvider.autoDispose<List<BookData>>((ref) {
  return FirebaseFirestore.instance
      .collection("allUsersBooks")
      .where('banned', isEqualTo: false)
      .snapshots()
      .map((snapshot) {
    final books = snapshot.docs.map((e) {
      final bookData = BookData.fromJson(e.data());
      return bookData;
    }).toList();
    return books;
  });
});

final favoritesCountProvider = StreamProvider.family<int, BookData>((ref, bookData) {  return FirebaseFirestore.instance
      .collection('users')
      .doc(bookData.email) // 書籍の投稿者の email を使用
      .collection('books')
      .doc(bookData.bookId)
      .collection('favorites')
      .snapshots()
      .map((snapshot) => snapshot.docs.length); // いいねの数をカウント
});


final favoritesProvider = StreamProvider.family<bool, BookData>((ref, bookData) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Stream.value(false);
  }
  return FirebaseFirestore.instance
      .collection('users')
      .doc(bookData.email) // 投稿者の email を使用
      .collection('books')
      .doc(bookData.bookId)
      .collection('favorites')
      .doc(user.uid)
      .snapshots()
      .map((snapshot) => snapshot.exists);
});

final favoritesUsersProvider = StreamProvider.family<List<FavoritesData>, BookData>((ref, bookData) {  return FirebaseFirestore.instance
      .collection('users')
      .doc(bookData.email) // 書籍の投稿者の email を使用
      .collection('books')
      .doc(bookData.bookId)
      .collection('favorites')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
    return FavoritesData.fromJson(doc.data());
  }).toList());
});

final commentsCountProvider = StreamProvider.family<int, BookData>((ref, bookData) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(bookData.email) // 書籍の投稿者の email を使用
      .collection('books')
      .doc(bookData.bookId)
      .collection('comments')
      .snapshots()
      .map((snapshot) => snapshot.docs.length); // コメントの数をカウント
});

final commentsDataProvider = StreamProvider.family<List<CommentData>, BookData>((ref, bookData) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(bookData.email) // 書籍の投稿者の email を使用
      .collection('books')
      .doc(bookData.bookId)
      .collection('comments')
      .orderBy('commentedAt', descending: true) // 最新のコメントが上に来るように
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => CommentData.fromJson(doc.data())).toList();
  });
});


class HomePageTabState extends ConsumerState<HomePageTab> {
  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(allUsersBooksProvider);

    return Scaffold(
      body: booksData.when(
        data: (books) {
          if (books.isEmpty) {
            return const Center(child: Text('本が追加されていません'));
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
                              const SizedBox(height: 8),
                              Text('作成日: ${DateFormat('yyyy-MM-dd HH:mm').format(book.createdAt)}'),
                              const SizedBox(height: 8),
                              Text(book.description),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: (){},
                                          icon: const Icon(Icons.favorite)
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  padding: const EdgeInsets.all(16),
                                                  width: MediaQuery.of(context).size.width,
                                                  height: MediaQuery.of(context).size.height*0.85,
                                                  child: Column(
                                                    children: [
                                                  Text(ref.watch(favoritesCountProvider(book)).when(
                                                  data: (favoritesCount) => 'いいね数：$favoritesCount',
                                                  loading: () => 'Loading...',
                                                  error: (error, _) => 'Error',
                                                )),
                                                const SizedBox(height: 16),
                                                      // いいねしたユーザーをListViewで表示
                                                      Expanded(
                                                        child: ref.watch(favoritesUsersProvider(book)).when(
                                                          data: (users) {
                                                            if (users.isEmpty) {
                                                              // いいねしたユーザーがいない場合
                                                              return const Center(
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text('いいねしたユーザーがいません。', style: TextStyle(fontSize: 18.0)),
                                                                    SizedBox(height: 8),
                                                                    Text('この投稿にいいねしよう！', style: TextStyle(fontSize: 16.0)),
                                                                  ],
                                                                ),
                                                              );
                                                            } else {
                                                              // いいねしたユーザーがいる場合
                                                              return ListView.builder(
                                                                itemCount: users.length,
                                                                itemBuilder: (context, index) {
                                                                  final user = users[index];
                                                                  return ListTile(
                                                                    leading: CircleAvatar(
                                                                      backgroundImage: NetworkImage(user.imageUrl),
                                                                    ),
                                                                    title: Text(user.username),
                                                                    subtitle: Text(user.email),
                                                                  );
                                                                  },
                                                              );
                                                            }
                                                            },
                                                          loading: () => const Center(child: CircularProgressIndicator()),
                                                          error: (error, _) => Center(child: Text('エラーが発生しました: $error')),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }
                                              );
                                          },
                                        child: Text(ref.watch(favoritesCountProvider(book)).when(
                                          data: (favoritesCount) => 'いいね数：$favoritesCount', // `count`を`favoritesCount`に変更
                                          loading: () => 'Loading...',
                                          error: (error, _) => 'Error',
                                        )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.comment),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height * 0.85,
                                              child: Column(
                                                children: [
                                              Text(ref.watch(commentsCountProvider(book)).when(
                                              data: (commentsCount) => 'コメント数：$commentsCount', // `count`を`commentsCount`に変更
                                              loading: () => 'Loading...',
                                              error: (error, _) => 'Error',
                                            )),
                                          const SizedBox(height: 16),
                                                  // コメントをListViewで表示
                                                  Expanded(
                                                    child: ref.watch(commentsDataProvider(book)).when(
                                                      data: (comments) {
                                                        if (comments.isEmpty) {
                                                          // コメントが一つもない場合
                                                          return const Center(
                                                            child: Text(
                                                              'コメントはまだありません。\nコメントを追加しましょう。',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 18.0,
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          // コメントがある場合
                                                          return ListView.builder(
                                                            itemCount: comments.length,
                                                            itemBuilder: (context, index) {
                                                              final comment = comments[index];
                                                              return ListTile(
                                                                leading: CircleAvatar(
                                                                  backgroundImage: NetworkImage(comment.commentatorImageUrl),
                                                                ),
                                                                title: Text(comment.commentatorUsername),
                                                                subtitle: Text(comment.comment),
                                                                trailing: Text(DateFormat('MM/dd HH:mm').format(comment.commentedAt)),
                                                              );
                                                            },
                                                          );
                                                        }
                                                      },
                                                      loading: () => const Center(child: CircularProgressIndicator()),
                                                      error: (error, _) => Center(child: Text('エラーが発生しました: $error')),
                                                    ),
                                                  ),
                                                  // コメント入力フィールド
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border: const OutlineInputBorder(),
                                                      labelText: 'コメントを追加...',
                                                      suffixIcon: IconButton(
                                                        icon: const Icon(Icons.send),
                                                        onPressed: () {
                                                          // コメントの送信処理を実装
                                                          // コメントテキストはTextFormFieldのコントローラーから取得
                                                        },
                                                      ),
                                                    ),
                                                    onFieldSubmitted: (value) {
                                                      // コメントの送信処理を実装
                                                      // 送信が成功したらFormFieldをクリア
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Text(ref.watch(commentsCountProvider(book)).when(
                                    data: (commentsCount) => 'コメント数：$commentsCount',
                                    loading: () => 'Loading...',
                                    error: (error, _) => 'Error',
                                  )),
                                ],
                              ),
                            ],
                          ),
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
                                          Text(userName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Text(
                                          book.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                      ),
                                      const SizedBox(height: 8),
                                      Text("作成日: ${DateFormat('yyyy-MM-dd HH:mm').format(book.createdAt)}"),
                                      const SizedBox(height: 8),
                                      Text(
                                        book.description,
                                        maxLines: 4,
                                      ),
                                      Row(
                                          children: [
                                            Consumer(builder: (context, ref, _) {
                                              // ここで BookData オブジェクトを favoritesProvider に渡す
                                              final isFavorite = ref.watch(favoritesProvider(book)).asData?.value ?? false;
                                              return Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      color: isFavorite ? Colors.red : Colors.grey,
                                                    ),
                                                  onPressed: () async{
                                                    // いいねボタンの onPressed コールバック内
                                                    final user = FirebaseAuth.instance.currentUser;
                                                    final userName = ref.read(userDataProvider)?.username;
                                                    final userImageUrl = ref.read(userDataProvider)?.imageUrl;
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
                                                  ),
                                                  Text(ref.watch(favoritesCountProvider(book)).when(
                                                    data: (favoritesCount) => '$favoritesCount',
                                                    loading: () => 'Loading...',
                                                    error: (error, _) => 'Error',
                                                  )),
                                                ],
                                              );
                                            }),
                                            const SizedBox(width: 16),
                                            Consumer(builder: (context, ref, _) {
                                              // BookData オブジェクトを使用してコメント数を取得
                                              return Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(Icons.comment),
                                                    onPressed: () {
                                                      // コメントボタンが押された時の処理（コメント表示ダイアログなど）
                                                    },
                                                  ),
                                                  Text(ref.watch(commentsCountProvider(book)).when(
                                                    data: (commentsCount) => '$commentsCount',
                                                    loading: () => 'Loading...',
                                                    error: (error, _) => 'Error',
                                                  )),
                                                ],
                                              );
                                            }),
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
                        return const Center(child: CircularProgressIndicator());
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
