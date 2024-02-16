import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPageTab extends ConsumerStatefulWidget {
  const MyPageTab({super.key});

  @override
  ConsumerState<MyPageTab> createState() => _MyPageTabState();
}

class _MyPageTabState extends ConsumerState<MyPageTab> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('エラー');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;
            final imageUrl =
                data['imageUrl'] as String? ?? 'No image';
            final username =
                data['username'] as String? ?? 'No name';
            final bookCount =
                data['bookCount'] as num? ?? 'No data';
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Image.network(imageUrl),
                ),
                SizedBox(height: 10),
                Text(username, style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text('読んだ本：$bookCount冊', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                //編集ボタン
                ElevatedButton(
                  onPressed: () {
                    // 編集画面に遷移
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditingMyData(),
                      ),
                    );
                  },
                  child: Text('編集'),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}