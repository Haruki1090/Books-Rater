import 'package:books_rater/book_data.dart';
import 'package:books_rater/editing_posted_book.dart';
import 'package:books_rater/home_page_tab.dart';
import 'package:books_rater/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MyBooksTab extends ConsumerStatefulWidget {
  const MyBooksTab({Key? key}) : super(key: key);

  @override
  MyBooksTabState createState() => MyBooksTabState();
}

Future<void> decrementBookCount(String email) async {
  HttpsCallable callable = FirebaseFunctions.instanceFor(region: "us-central1").httpsCallable('decrementBookCount');
  try {
    await callable.call(<String, dynamic>{
      'email': email,
    });
  } catch (e) {
    print(e);
  }
}

final myBooksStreamProvider = StreamProvider.autoDispose<List<BookData>>((ref) {
  final userCredential = ref.watch(authControllerProvider);
  if (userCredential == null) {
    throw Exception('User not logged in');
  } else {
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.email)
        .collection('books');
    final stream = collection.snapshots().map(
        (e) => e.docs.map((e) => BookData.fromJson(e.data())).toList()
    );
    return stream;
}
});

class MyBooksTabState extends ConsumerState<MyBooksTab> {
  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(myBooksStreamProvider);
    return Scaffold(
      body: booksData.when(
        data: (books) {
          if (books.isEmpty) {
            // 本のリストが空の場合、メッセージを表示
            return const Center(child: Text('本が追加されていません'));
          } else {
            // 本のリストにデータがある場合、リストを表示
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 250,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.keyboard_double_arrow_down),
                                title: const Text('閉じる'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.edit),
                                title: const Text('編集'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditingPostedBook(
                                            email: book.email,
                                            bookId: book.bookId,
                                            bookTitle: book.title,
                                            bookImageUrl: book.bookImageUrl,
                                            bookDescription: book.description,
                                            bookUpdatedAt: book.updatedAt,
                                            bookBanned: book.banned,
                                          )
                                      )
                                  );
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.delete),
                                title: const Text('削除'),
                                onTap: () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('本を削除しますか？'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('キャンセル'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (BuildContext context) {
                                                  return const Center(child: CircularProgressIndicator());
                                                },
                                              );

                                              FirebaseFirestore.instance.collection('users').doc(book.email).collection('books').doc(book.bookId).delete().then((_) {
                                                return decrementBookCount(FirebaseAuth.instance.currentUser!.email!);
                                              }).then((_) {
                                                // 本を削除した後の処理
                                                Navigator.pop(context); // ProgressDialogを閉じる
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text('本を削除しました'))
                                                );
                                                Navigator.pop(context); // 前の画面に戻る
                                              }).catchError((error) {
                                                Navigator.pop(context); // ProgressDialogを閉じる
                                                // エラーが発生した場合の処理
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('本の削除に失敗しました: $error'),
                                                    backgroundColor: Colors.redAccent,
                                                  ),
                                                );
                                              });
                                            },
                                            child: const Text('削除'),
                                          ),

                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 14, 8, 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text("作成日: ${DateFormat('yyyy-MM-dd').format(book.createdAt)}"),
                                const SizedBox(height: 12),
                                Text(
                                  book.description,
                                  maxLines: 3,
                                ),
                                //todo: いいねとコメントの数を表示
                                Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
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
                                      icon: const Icon(Icons.favorite),
                                      label: Text(ref.watch(favoritesCountProvider(book)).when(
                                        data: (favoritesCount) => 'いいね数：$favoritesCount', // `count`を`favoritesCount`に変更
                                        loading: () => 'Loading...',
                                        error: (error, _) => 'Error',
                                      )),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.comment),
                                      label: Text(ref.watch(commentsCountProvider(book)).when(
                                        data: (commentsCount) => 'コメント数：$commentsCount', // `count`を`commentsCount`に変更
                                        loading: () => 'Loading...',
                                        error: (error, _) => 'Error',
                                      )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: SizedBox(
                                width: 120*0.7,
                                height: 180*0.7,
                                child: Image.network(book.bookImageUrl, fit: BoxFit.cover),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラーが発生しました: $e')),
      ),
    );
  }
}