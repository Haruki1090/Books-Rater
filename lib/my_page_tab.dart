import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPageTab extends ConsumerWidget {
  const MyPageTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('MyPageTab', textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
    );
  }
}