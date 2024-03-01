import 'package:books_rater/book_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomePageTab extends ConsumerStatefulWidget {
  const HomePageTab({Key? key}) : super(key: key);

  @override
  _HomePageTabState createState() => _HomePageTabState();
}

final allUsersBooksProvider = StreamProvider.autoDispose<List<BookData>>((ref) {
  final stream = FirebaseFirestore.instance
      .collection('allUsersBooks')
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => BookData.fromJson(doc.data() as Map<String, dynamic>)).toList());
  return stream;
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
                                      Text(book.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      SizedBox(height: 8),
                                      Text("作成日: ${DateFormat('yyyy-MM-dd HH:mm').format(book.createdAt)}"),
                                      SizedBox(height: 8),
                                      Text(book.description),
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
