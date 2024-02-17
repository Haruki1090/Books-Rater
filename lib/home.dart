import 'package:books_rater/book_data.dart';
import 'package:books_rater/home_page_tab.dart';
import 'package:books_rater/my_books_tab.dart';
import 'package:books_rater/my_page_tab.dart';
import 'package:books_rater/sign_in_page.dart';
import 'package:books_rater/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserStateNotifier extends StateNotifier<UserData?> {
  UserStateNotifier() : super(null) {
    _loadUserData();
  }

  // ユーザーデータをリセットするメソッド
  void resetUserData() {
    state = null;
  }

  // 新しいユーザーデータの読み込みをトリガーする
  void reloadUserData() {
    _loadUserData();
  }

  Future<List<BookData>> fetchBooksFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    try {
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.email).get();
      final booksDynamic = userData.data()?['books'] as List<dynamic>? ?? [];
      // List<dynamic>をList<BookData>に変換
      final books = booksDynamic.map((book) => BookData.fromJson(book as Map<String, dynamic>)).toList();
      return books;
    } catch (e) {
      print("Error fetching books: $e");
      return [];
    }
  }


  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      final userDataDoc = await FirebaseFirestore.instance.collection('users').doc(user.email).get();
      final userData = userDataDoc.data();
      if (userData != null) {
        final books = await fetchBooksFromFirestore(); // 本のデータを取得
        state = UserData(
          uid: user.uid,
          email: user.email!,
          username: userData['username'] ?? '',
          imageUrl: userData['imageUrl'] ?? '',
          bookCount: userData['bookCount'] ?? 0,
          createdAt: (userData['createdAt'] as Timestamp).toDate(),
          updatedAt: (userData['updatedAt'] as Timestamp).toDate(),
          books: books, // 修正: fetchBooksFromFirestoreから取得したList<BookData>を使用
        );
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  Future<void> updateUserData(String username) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      // Firestoreのユーザーデータを更新
      await FirebaseFirestore.instance.collection('users').doc(user.email).update({
        'username': username,
        'updatedAt': DateTime.now(),
      });

      // Stateを更新
      state = state?.copyWith(username: username, updatedAt: DateTime.now());
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

}


final userDataProvider = StateNotifierProvider<UserStateNotifier, UserData?>((ref) {
  return UserStateNotifier();
});


class Home extends ConsumerStatefulWidget {
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> display = [HomePageTab(), MyBooksTab(), MyPageTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // サインアウトボタン
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final result = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('サインアウトしますか？'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('サインアウト'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('キャンセル'),
                        ),
                      ],
                    );
                  }
              );
              if (result == true) {
                // FirebaseAuthでサインアウト
                await FirebaseAuth.instance.signOut();
                // UserStateNotifierの状態をリセット
                ref.read(userDataProvider.notifier).resetUserData();
                // サインインページへ遷移
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                      (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),

      body: display[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Page',
          ),
        ],
      ),
    );
  }
}

