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
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => BookData.fromJson(doc.data() as Map<String, dynamic>)).toList()
  );
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
                    // Implement tap action
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            //backgroundImage: NetworkImage(book.bookImageUrl),
                            radius: 20,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(book.uid, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)), // Assuming 'userName' is a field in BookData
                                Text(book.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 8),
                                Text("作成日: ${DateFormat('yyyy-MM-dd').format(book.createdAt)}"),
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
