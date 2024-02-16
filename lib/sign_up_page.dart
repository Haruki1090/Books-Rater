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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          /// Sign up Form
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'アカウント 新規登録',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  // username
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // mailAdress
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // password
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // confirm password
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Password (再入力)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // Sign up button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
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
                                title: const Text('エラー'),
                                content: const Text('全ての項目を入力してください。'),
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
                          //プログレスインジケーター
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          final UserCredential userCredential = await ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          // 登録成功
                          print('登録成功');
                          //スナックバーを表示
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('登録に成功しました。'),
                            ),
                          );

                        } on FirebaseAuthException catch (e) {
                          print('Firebase Authエラー: $e');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('エラー'),
                                content: const Text('登録に失敗しました。'),
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
                        }
                      },
                      child: const Text('サインアップ'),
                    ),
                  ),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('アカウントを既にお持ちの場合'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
