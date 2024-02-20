import 'package:books_rater/home.dart';
import 'package:books_rater/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeProvider = StateProvider((ref) => false);

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isDarkModeEnabled = ref.watch(darkModeProvider);
    final String currentMode = isDarkModeEnabled ? 'ダークモード' : 'ライトモード';

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              title: Text(currentMode),
              trailing: CupertinoSwitch(
                value: isDarkModeEnabled,
                onChanged: (bool newValue) {
                  ref.read(darkModeProvider.notifier).state = newValue;
                },
              ),
            ),

            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('サインアウト'),
              onPressed: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('サインアウトしますか？'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('サインアウト'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('キャンセル'),
                      ),
                    ],
                  ),
                );
                if (result == true) {
                  // FirebaseAuth サインアウト処理
                  await FirebaseAuth.instance.signOut();
                  // UserStateNotifier リセット
                  ref.read(userDataProvider.notifier).resetUserData();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('サインアウトしました')),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                        (Route<dynamic> route) => false,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
