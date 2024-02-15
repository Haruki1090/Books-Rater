import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyBooksTab extends ConsumerStatefulWidget {
  const MyBooksTab({super.key});

  @override
  ConsumerState<MyBooksTab> createState() => _MyBooksTabState();
}

class _MyBooksTabState extends ConsumerState<MyBooksTab> {
  @override
  Widget build(BuildContext context) {
    return Text('MyBooksTab');
  }
}
