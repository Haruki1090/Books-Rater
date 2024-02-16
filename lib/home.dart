import 'package:books_rater/home_page_tab.dart';
import 'package:books_rater/my_books_tab.dart';
import 'package:books_rater/my_page_tab.dart';
import 'package:books_rater/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  ConsumerState<Home> createState() => _HomeState();
}

final firebaseAuthProvider = StateProvider((ref) => FirebaseAuth.instance);
final currentIndexProvider = StateProvider<int>((ref) => 0);

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
        actions: [
          // sign out button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Sign outしますか？
              final signOutCheck = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Sign out'),
                    content: const Text('サインアウトしますか？'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SignInPage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        child: const Text('サインアウト'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('キャンセル'),
                      ),
                    ],
                  );
                }
              );
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
