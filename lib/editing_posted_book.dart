import 'package:books_rater/controllers/banned_controller.dart';
import 'package:books_rater/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'date_time_timestamp_converter.dart';
import 'package:books_rater/controllers/description_controller.dart';

class EditingPostedBook extends ConsumerStatefulWidget {
  final String email;
  final String bookId;
  final String bookTitle;
  final String bookImageUrl;
  final String bookDescription;
  final DateTime bookUpdatedAt;
  final bool bookBanned;

  const EditingPostedBook(
      {Key? key,
        required this.email,
        required this.bookId,
        required this.bookTitle,
        required this.bookImageUrl,
        required this.bookDescription,
        required this.bookUpdatedAt,
        required this.bookBanned
      }) : super(key: key);

  @override
  ConsumerState<EditingPostedBook> createState() => _EditingPostedBookState();
}

class _EditingPostedBookState extends ConsumerState<EditingPostedBook> {

  Future<void> upDatePostedBookData() async {
    // 現在の状態を読み取る
    final currentDescription = ref.read(descriptionControllerNotifierProvider);
    final currentBanned = ref.read(bannedControllerNotifierProvider);

    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .collection('books')
        .doc(widget.bookId)
        .update({
      'description': currentDescription,
      'banned': currentBanned,
      'updatedAt': Timestamp.now(),
    }).then((_) {
      return updateBookInAllUsersBooks(widget.bookId, currentDescription, currentBanned);
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('更新に成功しました'),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('更新に失敗しました: $e')),
      );
    });
  }


  Future<void> updateBookInAllUsersBooks(String targetBookId, String currentDescription, bool currentBanned) async {
    try {
      // allUsersBooks コレクション内のドキュメントを取得
      final querySnapshot = await FirebaseFirestore.instance.collection('allUsersBooks').get();

      // 各ドキュメントに対してループ処理
      for (var doc in querySnapshot.docs) {
        // ドキュメント内の bookId フィールドが目的の bookId と一致するか確認
        if (doc.data()['bookId'] == targetBookId) {
          // 一致する場合、そのドキュメントを更新
          await FirebaseFirestore.instance.collection('allUsersBooks').doc(doc.id).update({
            'description': currentDescription,
            'banned': currentBanned,
            'updatedAt': Timestamp.now(),
          });
          break; // 一致するドキュメントを更新したらループを抜ける
        }
      }
    } catch (e) {
      throw 'allUsersBooks コレクションの更新に失敗しました: $e';
    }
  }



  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(descriptionControllerNotifierProvider.notifier).fetchBookDescription(widget.bookDescription);
      ref.read(bannedControllerNotifierProvider.notifier).fetchBookBanned(widget.bookBanned);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
        title: const Text('本の編集'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: SizedBox(
                width: 120*1.7,
                height: 180*1.7,
                child: Image.network(widget.bookImageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),
            Text(widget.bookTitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: widget.bookDescription,
              decoration: const InputDecoration(
                labelText: '本の説明',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) {
                ref.read(descriptionControllerNotifierProvider.notifier).fetchBookDescription(value);
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('ホーム非表示にする'),
              trailing: Consumer(
                builder: (context, ref, _) {
                  final banned = ref.watch(bannedControllerNotifierProvider);
                  return CupertinoSwitch(
                    value: banned,
                    onChanged: (bool newValue) {
                      ref.read(bannedControllerNotifierProvider.notifier).fetchBookBanned(newValue);
                      },
                  );
                  },
              ),
            ),
            const SizedBox(height: 20),
            Text('最終更新日時: ${widget.bookUpdatedAt.format()}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
                upDatePostedBookData().then((_) {
                  // 成功した場合の処理
                  Navigator.of(context).pop(); // ProgressDialogを閉じる
                  Navigator.of(context).pop(); // 前の画面に戻る
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('更新に成功しました'),
                      backgroundColor: Colors.greenAccent,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }).catchError((error) {
                  Navigator.of(context).pop(); // ProgressDialogを閉じる
                  // エラーが発生した場合の処理
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('更新に失敗しました: $error'),
                      backgroundColor: Colors.redAccent,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                });
              },
              child: const Text('更新する'),
            ),

          ],
        ),
      ),
    );
  }
}


