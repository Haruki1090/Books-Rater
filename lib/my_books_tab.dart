import 'package:books_rater/book_data.dart';
import 'package:books_rater/comment_data.dart';
import 'package:books_rater/controllers/auth_controller.dart';
import 'package:books_rater/controllers/comments_count_controller.dart';
import 'package:books_rater/controllers/user_data_controller.dart';
import 'package:books_rater/date_format.dart';
import 'package:books_rater/editing_posted_book.dart';
import 'package:books_rater/controllers/favorites_count_controller.dart';
import 'package:books_rater/home_page_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myBooksStreamProvider = StreamProvider.autoDispose<List<BookData>>((ref) {
  final userCredential = ref.watch(authControllerNotifierProvider);
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
    throw Exception('Firebase function call failed');
  }
}

class MyBooksTabState extends ConsumerState<MyBooksTab> {
  final _newCommentController = TextEditingController();

  @override
  void dispose() {
    _newCommentController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(myBooksStreamProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[850]
          : Colors.grey[100],
      body: CustomScrollView(
        slivers:[
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.18,
            flexibleSpace: Image.network(
                ref.read(userDataControllerNotifierProvider)?.imageUrl ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
              ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  '${ref.read(userDataControllerNotifierProvider)?.username}の本棚：${booksData.when(
                    data: (books) => books.length,
                    loading: () => 'Loading...',
                    error: (error, _) => 'Error',
                  )}冊',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ),
          booksData.when(
            data: (books) {
              if (books.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 160),
                      Text(
                        '本が追加されていません',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '右下のボタンを押して本を追加しよう！',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                return SliverFixedExtentList(
                  itemExtent: 180,
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final book = books[index];
                      // 各アイテムのウィジェットを構築
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.grey[850]
                                      : Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
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
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[850]
                              : Colors.white,
                          surfaceTintColor: Colors.white,
                          elevation: 5,
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
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text("作成日: ${book.createdAt.format()}"),
                                      const SizedBox(height: 12),
                                      Text(
                                        book.description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          TextButton.icon(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[850] : Colors.white,
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(16),
                                                          topRight: Radius.circular(16),
                                                        ),
                                                      ),
                                                      padding: const EdgeInsets.all(16),
                                                      width: MediaQuery.of(context).size.width,
                                                      height: MediaQuery.of(context).size.height*0.85,
                                                      child: Column(
                                                        children: [
                                                          Text(ref.watch(favoritesCountControllerNotifierProvider(book)).when(
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
                                            icon: Icon(
                                                Icons.favorite,
                                                color: Theme.of(context).brightness == Brightness.dark
                                                    ? Colors.white // ダークモードの時のアイコンカラー
                                                    : Colors.grey // ライトモードの時のアイコンカラー
                                            ),
                                            label: Text(ref.watch(favoritesCountControllerNotifierProvider(book)).when(
                                              data: (favoritesCount) => 'いいね数：$favoritesCount',
                                              loading: () => 'Loading...',
                                              error: (error, _) => 'Error',
                                            ),
                                                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
                                          ),
                                          TextButton.icon(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[850] : Colors.white,
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(16),
                                                          topRight: Radius.circular(16),
                                                        ),
                                                      ),
                                                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 46),
                                                    width: MediaQuery.of(context).size.width,
                                                    height: MediaQuery.of(context).size.height * 0.85,
                                                    child: Column(
                                                      children: [
                                                        Text(ref.watch(commentsCountControllerNotifierProvider(book)).when(
                                                          data: (commentsCount) => 'コメント数：$commentsCount',
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
                                                                        trailing: Text(comment.commentedAt.format()),
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
                                                            controller: _newCommentController,
                                                            decoration: InputDecoration(
                                                              border: const OutlineInputBorder(),
                                                              labelText: 'コメントを追加...',
                                                              suffixIcon: IconButton(
                                                                icon: const Icon(Icons.send),
                                                                onPressed: () async{
                                                                  final newComment = CommentData(
                                                                    comment: _newCommentController.text,
                                                                    commentatorUsername: ref.read(userDataControllerNotifierProvider)?.username ?? '不明',
                                                                    commentatorUid: ref.read(userDataControllerNotifierProvider)?.uid ?? '不明',
                                                                    commentatorEmail: ref.read(userDataControllerNotifierProvider)?.email ?? '不明',
                                                                    commentatorImageUrl: ref.read(userDataControllerNotifierProvider)?.imageUrl ?? 'デフォルト画像URL',
                                                                    commentedAt: DateTime.now(),
                                                                  );
                                                                  await FirebaseFirestore.instance.collection('users').doc(book.email).collection('books').doc(book.bookId).collection('comments').add(newComment.toJson());
                                                                  _newCommentController.clear();
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                                Icons.comment,
                                                color: Theme.of(context).brightness == Brightness.dark
                                                    ? Colors.white // ダークモードの時のアイコンカラー
                                                    : Colors.grey // ライトモードの時のアイコンカラー
                                            ),
                                            label: Text(ref.watch(commentsCountControllerNotifierProvider(book)).when(
                                              data: (commentsCount) => 'コメント数：$commentsCount',
                                              loading: () => 'Loading...',
                                              error: (error, _) => 'Error',
                                            ),
                                                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
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
                    childCount: books.length,
                  ),
                );
              }
            },
            loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
            error: (e, _) => SliverToBoxAdapter(child: Center(child: Text('エラーが発生しました: $e'))),
          ),
        ],
      ),
    );
  }
}