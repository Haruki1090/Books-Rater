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
    // 現在のダークモードの状態を監視
    final bool isDarkModeEnabled = ref.watch(darkModeProvider);
    // 現在のモードに応じて表示テキストを設定
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
              title: Text(currentMode), // 現在のモードを表示
              trailing: CupertinoSwitch(
                value: isDarkModeEnabled, // 現在の状態をスイッチに反映
                onChanged: (bool newValue) {
                  // スイッチの新しい値で状態を更新
                  ref.read(darkModeProvider.notifier).state = newValue;
                },
              ),
            ),

            ElevatedButton.icon(
              icon: const Icon(Icons.logout), // アイコンを設定
              label: const Text('サインアウト'), // ボタンのテキスト
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
                  // FirebaseAuthでサインアウトする処理
                  await FirebaseAuth.instance.signOut();
                  // UserStateNotifierをリセット
                  ref.read(userDataProvider.notifier).resetUserData();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('サインアウトしました')),
                  );

                  // SignInPageへ遷移
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
