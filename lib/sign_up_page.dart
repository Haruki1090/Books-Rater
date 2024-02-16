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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sign UP'),
      ),
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
                      onPressed: () {

                      },
                      child: const Text('登録内容を確認'),
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
