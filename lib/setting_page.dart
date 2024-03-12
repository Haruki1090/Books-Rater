import 'package:books_rater/controllers/user_data_controller.dart';
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
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
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
              icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black // ダークモードの時のアイコンカラー
                      : Colors.white // ライトモードの時のアイコンカラー
              ),
              label: Text(
                'サインイン',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black // ダークモードの時のテキストカラー
                      : Colors.white, // ライトモードの時のテキストカラー
                ),
              ),
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800] // ダークモードの時の背景色
                        : Colors.white,// ライトモードの時の背景色
                    surfaceTintColor: Colors.white,
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
                ).then((result) {
                  if (result == true) {
                    FirebaseAuth.instance.signOut().then((_) {
                      ref.read(userDataControllerNotifierProvider.notifier).resetUserData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('サインアウトしました')),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInPage()),
                            (Route<dynamic> route) => false,
                      );
                    });
                  }
                });
              },
            )

          ],
        ),
      ),
    );
  }
}
