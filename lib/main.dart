import 'package:books_rater/home.dart';
import 'package:books_rater/home_page_tab.dart';
import 'package:books_rater/setting_page.dart';
import 'package:books_rater/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white, // ライトモードの背景色
          foregroundColor: Colors.black, // ライトモードのアイコン色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)), // 角丸の形状
            side: BorderSide(color: Colors.black, width: 4), // 太線で黒色の外枠線
          ),
        ),

        // ライトモード時の入力欄のテーマ
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: Colors.black, width: 5.0),
          ),
          fillColor: Colors.white, // ライトモードの入力欄の背景色
          filled: true,
        ),

        // ライトモード時の影のテーマ
        shadowColor: Colors.grey[500], // ライトモードでの影の色
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,

        // ダークモード時のボトムナビゲーションバーのテーマ
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white, // ダークモード時の選択されたアイテムの色
        ),

        // ダークモード時のFABのテーマ
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black, // ダークモードの背景色
          foregroundColor: Colors.white, // ダークモードのアイコン色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)), // 角丸の形状
            side: BorderSide(color: Colors.white, width: 2), // 太線で白色の外枠線
          ),
        ),

        // ダークモード時の入力欄のテーマ
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: Colors.white, width: 5.0), // ダークモードの外枠線
          ),
          fillColor: Colors.grey.shade800, // ダークモードの入力欄の背景色（薄いグレー）
          filled: true,
        ),

        // ダークモード時の影のテーマ
        shadowColor: Colors.white24, // ダークモードでの影の色
      ),
      themeMode: themeMode,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return const Home();
          }
          return const SignInPage();
        },
      ),
    );
  }
}