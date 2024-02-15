import 'package:books_rater/my_books_tab.dart';
import 'package:books_rater/my_page_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTab extends ConsumerStatefulWidget {
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  final currentIndexProvider = StateProvider<int>((ref) => 0);

  void _onItemTapped(int index) {
    ref.read(currentIndexProvider.notifier).update((index) => index);
    if (index == 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProviderScope(
                  child: HomeTab()
              )
          )
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyBooksTab())
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyPageTab())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Books Rater Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to Books Rater App'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.read(currentIndexProvider),
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
