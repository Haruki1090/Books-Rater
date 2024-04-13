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
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
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
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Theme.of(context).brightness == Brightness.dark
                                ? Colors.white // ダークモードの時のボタンの背景色
                                : Colors.black; // ライトモードの時のボタンの背景色
                          }
                          return Theme.of(context).brightness == Brightness.dark
                              ? Colors.white // ダークモードの時のボタンの背景色
                              : Colors.black; // ライトモードの時のボタンの背景色
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
                            ? Colors.black // ダークモードの時のテキストカラー
                            : Colors.white, // ライトモードの時のテキストカラー
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
                        return Theme.of(context).brightness == Brightness.dark
                            ? Colors.white // ダークモードの時のボタンの背景色
                            : Colors.black; // ライトモードの時のボタンの背景色
                      }
                      return Theme.of(context).brightness == Brightness.dark
                          ? Colors.white // ダークモードの時のボタンの背景色
                          : Colors.black; // ライトモードの時のボタンの背景色
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
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800] // ダークモードの時の背景色
              : Colors.white,// ライトモードの時の背景色
          surfaceTintColor: Colors.white,
          title: const Text('エラー'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Theme.of(context).brightness == Brightness.dark
                          ? Colors.white // ダークモードの時のボタンの背景色
                          : Colors.black; // ライトモードの時のボタンの背景色
                    }
                    return Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // ダークモードの時のボタンの背景色
                        : Colors.black; // ライトモードの時のボタンの背景色
                  },
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black // ダークモードの時のテキストカラー
                      : Colors.white, // ライトモードの時のテキストカラー
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
