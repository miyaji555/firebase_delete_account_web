import 'package:firebase_delete_account_web/provider/login_state_provider.dart';
import 'package:firebase_delete_account_web/repository/auth_repository.dart';
import 'package:firebase_delete_account_web/util/scaffold_messanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/auth_controller.dart';
import '../router.dart';
import 'dialog.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginStateProvider);
    final emailController = useTextEditingController();
    final passController = useTextEditingController();

    return state.when(
      data: (data) {
        // ログイン済みの場合
        if (data != null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(kPageNameMain),
            ),
            body: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        showConfirmDialog(
                            context: context,
                            message: "退会するとデータの復元はできなくなります。",
                            title: "退会しますか？",
                            okText: "退会する。",
                            function: () async {
                              await ref
                                  .read(authRepositoryProvider)
                                  .deleteUser();
                            });
                      },
                      child: const Text('退会する')),
                ],
              ),
            ),
          );
        }
        // 未ログインの場合
        return Scaffold(
          appBar: AppBar(
            title: const Text(kPageNameMain),
          ),
          body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: 'メールアドレス',
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  TextField(
                    controller: passController, // Controller実装必要
                    obscureText: true,
                    obscuringCharacter: 'Θ',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: 'パスワード',
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                      onPressed: () async {
                        await ref.read(authControllerProvider.notifier).signIn(
                            email: emailController.text,
                            password: passController.text,
                            onCompleted: () {});
                      },
                      child: const Text('ログイン')),
                  const SizedBox(height: 24.0),
                  TextButton(
                    onPressed: () async {
                      if (emailController.text.isEmpty) {
                        ref.read(scaffoldMessengerHelperProvider).showSnackBar(
                            "メールアドレスを入力してください。",
                            isWarningMessage: true);
                      }
                      await ref
                          .read(authRepositoryProvider)
                          .passwordReset(emailController.text);
                    },
                    child: const Text("パスワードを忘れた方"),
                  ),
                ],
              )),
        );
      },
      error: (_, __) {
        return const Scaffold(
          body: Center(
            child: Text('エラーだよ'),
          ),
        );
      },
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
