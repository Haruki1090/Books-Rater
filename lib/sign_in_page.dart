import 'package:books_rater/controllers/user_data_controller.dart';
import 'package:books_rater/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home.dart';

class AuthController extends StateNotifier<User?>{
  AuthController({User? initialUser}) : super(initialUser) {
    _auth.userChanges().listen((user){
      state = user;
    });
  }
}

final _auth = FirebaseAuth.instance;

Future<void>signInWithEmailAndPassword(String email, String password) async {
}

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'アカウント情報を入力',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      // ボタンの背景色　ダークモード時は黒、ライトモード時は白
                      // ボタンの影の深さ　押下時は影をなくす、通常時は10
                      // ボタンのテキストカラー　ダークモード時は白、ライトモード時は黒
                      // ボタンの外枠線の色　ダークモード時は白、ライトモード時は黒
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                          }
                          return Theme.of(context).brightness == Brightness.dark
                              ? Colors.black // ダークモードの時のボタンの背景色
                              : Colors.white; // ライトモードの時のボタンの背景色
                        },
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return 0; // 押下時は影をなくす
                          }
                          return 10; // 通常時の影の深さ
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Theme.of(context).brightness == Brightness.dark
                              ? Colors.black // ダークモードの時のテキストカラー
                              : Colors.white; // ライトモードの時のテキストカラー
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white // ダークモードの時の外枠線の色
                                  : Colors.black, // ライトモードの時の外枠線の色
                            ),
                          );
                        },
                      ),
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          // 押下時に透明色を適用
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.transparent;
                          }
                          // デフォルト状態でのオーバーレイ色を設定（ここでは透明を選択）
                          return Colors.transparent;
                        },
                      ),
                    ),
                    onPressed: () {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        _showErrorDialog('正しいメールアドレスとパスワードを入力してください。');
                        return;
                      }

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(child: CircularProgressIndicator());
                        },
                      );

                      FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      ).then((_) {
                        Navigator.of(context).pop(); // プログレスダイアログを閉じる

                        // サインイン成功時の処理
                        ref.read(userDataControllerNotifierProvider.notifier).reloadUserData();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('サインインしました')),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                              (Route<dynamic> route) => false,
                        );
                      }).catchError((error) {
                        Navigator.of(context).pop(); // プログレスダイアログを閉じる
                        if (error is FirebaseAuthException) {
                          _showErrorDialog('サインインに失敗しました。');
                        }
                      });
                    },
                    child: Text(
                      'サインイン',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white // ダークモードの時のテキストカラー
                            : Colors.black, // ライトモードの時のテキストカラー
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                      }
                      return Theme.of(context).brightness == Brightness.dark
                          ? Colors.white // ダークモードの時のボタンの背景色
                          : Colors.black; // ライトモードの時のボタンの背景色
                    },
                  ),
                elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return 0; // 押下時は影をなくす
                    }
                    return 10; // 通常時の影の深さ
                  },
                ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: Text(
                  'アカウントをお持ちでない場合',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black // ダークモードの時のテキストカラー
                        : Colors.white, // ライトモードの時のテキストカラー
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('エラー'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('閉じる'),
            ),
          ],
        );
      },
    );
  }
}
