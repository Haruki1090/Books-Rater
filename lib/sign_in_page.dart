import 'package:books_rater/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home.dart';

class SignInPage extends ConsumerStatefulWidget {
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

final firebaseAuthProvider = StateProvider((ref) => FirebaseAuth.instance);

class _SignInPageState extends ConsumerState<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('サインイン'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          _showErrorDialog('メールアドレスとパスワードを入力してください。');
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
                          await ref.read(firebaseAuthProvider).signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          // ログイン成功
                          print('ログイン成功');
                          //スナックバーを表示
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('ログインに成功しました。'),
                            ),
                          );
                          // ホームタブ画面に遷移
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                                (Route<dynamic> route) => false,
                          );
                        } on FirebaseAuthException catch (e) {
                          print('Firebase Authエラー: $e');
                          _showErrorDialog('ログインに失敗しました。');
                        }
                      },
                      child: const Text('サインイン'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: const Text('アカウントをお持ちでない場合'),
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
