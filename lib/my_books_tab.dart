import 'package:books_rater/book_data.dart';
import 'package:books_rater/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


class MyBooksTab extends ConsumerStatefulWidget {
  const MyBooksTab({Key? key}) : super(key: key);

  @override
  _MyBooksTabState createState() => _MyBooksTabState();
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

class _MyBooksTabState extends ConsumerState<MyBooksTab> {
  @override
  Widget build(BuildContext context) {
    final booksData = ref.watch(myBooksStreamProvider);
    return Scaffold(
      body: booksData.when(
        data: (books) {
          if (books.isEmpty) {
            // 本のリストが空の場合、メッセージを表示
            return Center(child: Text('本が追加されていません'));
          } else {
            // 本のリストにデータがある場合、リストを表示
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return InkWell(
                  onTap: () {
                    // 本がタップされたときの処理
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text("作成日: ${DateFormat('yyyy-MM-dd').format(book.createdAt)}"),
                                SizedBox(height: 30),
                                Text(book.description),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 120,
                              height: 180,
                              child: Image.network(book.bookImageUrl, fit: BoxFit.cover),
                            ),
                          ),
                        ),

                      ],
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