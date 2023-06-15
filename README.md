## Description
FirebaseAuthのログイン機能と退会機能だけを持ったWebアプリです。

## Purpose
近年GooglePlayConsoleのデータセーフティセクションでアプリ外でのアカウント削除が義務付けられました。
サクッとアプリ作ってリリースしたいだけなのにWebアプリまで開発しなきゃいけないとなってリリースのハードルが上がってしまうので、本当に簡単な退会機能だけを持つアプリです。


## Usage
Use this repositoryからRepositoryを作成してください。
作成したRepositoryをローカルにCloneしたのち、Firebaseの設定を行います。下記コマンドをTerminalに入力します。

```
flutterfire configure
```
すると対話形式で設定を聞かれます。


まずは自分のプロジェクトの一覧が表示されるので十字キーとEnterキーを使って選択
```
Select a Firebase project to configure your Flutter application with 
```

次にプラットフォームを聞かれるのでWebを選択
```
Which platforms should your configuration support (use arrow keys & space to select)?
```

最後にlib/firebase_options.dartを上書きしていいか聞かれるので yes と入力

```
Generated FirebaseOptions file lib/firebase_options.dart already exists, do you want to override it? 
```

これでfirebase_optionsが設定されるので、FirebaseProjectと接続が完了します。
