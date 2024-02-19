import 'package:books_rater/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:books_rater/book_data.dart';
import 'package:books_rater/home_page_tab.dart';
import 'package:books_rater/my_books_tab.dart';
import 'package:books_rater/my_page_tab.dart';
import 'package:books_rater/user_data.dart';

class UserStateNotifier extends StateNotifier<UserData?> {
  UserStateNotifier() : super(null) {
    _loadUserData();
  }

  void resetUserData() {
    state = null;
  }

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
        final books = await fetchBooksFromFirestore();
        state = UserData(
          uid: user.uid,
          email: user.email!,
          username: userData['username'] ?? '',
          imageUrl: userData['imageUrl'] ?? '',
          bookCount: userData['bookCount'] ?? 0,
          createdAt: (userData['createdAt'] as Timestamp).toDate(),
          updatedAt: (userData['updatedAt'] as Timestamp).toDate(),
          books: books,
        );
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  Future<void> updateUserData(String username, {String? imageUrl}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      Map<String, dynamic> updates = {'username': username, 'updatedAt': DateTime.now()};
      if (imageUrl != null) updates['imageUrl'] = imageUrl;

      // Firestoreのユーザーデータを更新
      await FirebaseFirestore.instance.collection('users').doc(user.email).update(updates);

      // 現在のstateを取得し、nullでない場合のみ新しい値で更新する
      UserData? currentState = state;
      if (currentState != null) {
        // 新しい値でstateを更新
        UserData updatedState = currentState.copyWith(
          username: username,
          imageUrl: imageUrl ?? currentState.imageUrl, // imageUrlがnullなら現在の値を保持
          updatedAt: DateTime.now(),
        );
        state = updatedState; // StateNotifierのstateを更新
      }
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

}

final userDataProvider = StateNotifierProvider<UserStateNotifier, UserData?>((ref) {
  return UserStateNotifier();
});

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
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
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage()));
          }, icon: const Icon(Icons.settings)),
        ],
      ),
      body: display[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('本を追加'),
                content: SingleChildScrollView(),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('キャンセル'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('追加'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Books'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Page'),
        ],
      ),
    );
  }
}
