import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageTab extends ConsumerStatefulWidget {
  const HomePageTab({super.key});

  @override
  ConsumerState<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends ConsumerState<HomePageTab> {
  @override
  Widget build(BuildContext context) {
    return Text('HomePageTab');
  }
}
