import 'package:books_rater/setting_page.dart';
import 'package:books_rater/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    // 縦画面固定
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(darkModeProvider)
        ? ThemeMode.dark
        : ThemeMode.light;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books Rater App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        // ライトモード時のボトムナビゲーションバーのテーマ
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black, // ライトモード時の選択されたアイテムの色
        ),
        // ライトモード時のFABのテーマ
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white, // ライトモードの背景色
          foregroundColor: Colors.black, // ライトモードのアイコン色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)), // 角丸の形状
            side: BorderSide(color: Colors.black, width: 2), // 太線で黒色の外枠線
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // ダークモード時のボトムナビゲーションバーのテーマ
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white, // ダークモード時の選択されたアイテムの色
        ),
        // ダークモード時のFABのテーマ
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black, // ダークモードの背景色
          foregroundColor: Colors.white, // ダークモードのアイコン色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)), // 角丸の形状
            side: BorderSide(color: Colors.white, width: 2), // 太線で白色の外枠線
          ),
        ),
      ),
      themeMode: themeMode,
      home: const SignInPage(),
    );
  }
}