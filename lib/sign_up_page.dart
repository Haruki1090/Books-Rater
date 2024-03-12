import 'package:books_rater/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

final firebaseAuthProvider = StateProvider((ref) => FirebaseAuth.instance);

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _usernameController = TextEditingController(); // username
  final _emailController = TextEditingController(); // emailAddress
  final _passwordController = TextEditingController(); // password
  final _confirmPasswordController = TextEditingController(); // confirm password

  bool _isObscure = true;
  bool _isObscureConfirm = true;

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
                  'アカウント 新規登録',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                    ),
                  ),
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
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: _isObscureConfirm,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_isObscureConfirm ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscureConfirm = !_isObscureConfirm;
                          });
                        },
                      ),
                      labelText: 'Password (再入力)',
                      prefixIcon: const Icon(Icons.lock_outline),
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
                    onPressed: () async {
                      final username = _usernameController.text.trim();
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      final confirmPassword = _confirmPasswordController.text.trim();

                      if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.black // ダークモードの時の背景色
                                  : Colors.white, // ライトモードの時の背景色
                              title: const Text('エラー'),
                              content: const Text('全ての項目を入力してください。'),
                              actions: [
                                TextButton(
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
                                    Navigator.pop(context);
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
                        return;
                      }

                      if (password != confirmPassword) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('エラー'),
                              content: const Text('パスワードが一致しません。'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }

                      try {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('登録に成功しました。'),
                          ),
                        );

                        await FirebaseFirestore.instance.collection('users').doc(email).set({
                          'uid': email,
                          'username': username,
                          'bookCount': 0,
                          'createdAt': DateTime.now(),
                          'updatedAt': DateTime.now(),
                          'imageUrl': 'https://knsoza1.com/wp-content/uploads/2020/07/70b3dd52350bf605f1bb4078ef79c9b9.png',
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                              (Route<dynamic> route) => false,
                        );
                      } on FirebaseAuthException {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('エラー'),
                              content: const Text('登録に失敗しました。'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                                          (Route<dynamic> route) => false,
                                    );
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'サインアップ',
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
                  Navigator.pop(context);
                },
                child: Text(
                  'アカウントをすでにお持ちの方',
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
}
