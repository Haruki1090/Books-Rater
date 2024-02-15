import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPageTab extends ConsumerStatefulWidget {
  const MyPageTab({super.key});

  @override
  ConsumerState<MyPageTab> createState() => _MyPageTabState();
}

class _MyPageTabState extends ConsumerState<MyPageTab> {
  @override
  Widget build(BuildContext context) {
    return Text('MyPageTab');
  }
}
