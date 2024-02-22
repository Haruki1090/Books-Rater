import 'package:books_rater/book_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final booksStreamProvider = StreamProvider<List<BookData>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  print(user);
  if (user == null) {
    return Stream.value([]);
  }
  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('books')
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => BookData.fromJson(doc.data() as Map<String, dynamic>))
      .toList());
});

class MyBooksTab extends ConsumerWidget {
  const MyBooksTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBooks = ref.watch(booksStreamProvider);

    return Scaffold(
      body: asyncBooks.when(
        data: (books) => ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return InkWell(
              onTap: () {
                // タップされたときの機能をここに実装
                // 例: 詳細ページへのナビゲーションやダイアログの表示など
              },
              child: Card(
                child: Row(
                  children: [
                    // 左側のテキスト情報
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
                            Text("作成日: ${book.createdAt.toString()}"),
                            SizedBox(height: 8),
                            Text(book.description),
                          ],
                        ),
                      ),
                    ),
                    // 右側のサムネイル画像
                    Container(
                      width: 120, // 画像の幅を指定
                      height: 180, // 画像の高さを指定
                      child: Image.network(book.bookImageUrl, fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }
}

