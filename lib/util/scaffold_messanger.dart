import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final scaffoldMessengerKeyProvider = Provider(
  (_) => GlobalKey<ScaffoldMessengerState>(),
);

final scaffoldMessengerHelperProvider = Provider.autoDispose(
  ScaffoldMessengerHelper.new,
);

/// ツリー上部の ScaffoldMessenger 上でスナックバーやダイアログの表示を操作する。
class ScaffoldMessengerHelper {
  ScaffoldMessengerHelper(this._ref);

  static const defaultSnackBarBehavior = SnackBarBehavior.floating;
  static const defaultSnackBarDuration = Duration(seconds: 3);

  final AutoDisposeProviderRef<ScaffoldMessengerHelper> _ref;

  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _ref.read(scaffoldMessengerKeyProvider);

  /// showDialog で指定したビルダー関数を返す。
  Future<T?> showDialogByBuilder<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: scaffoldMessengerKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }

  /// スナックバーを表示する。
  void showSnackBar(
    String message, {
    bool removeCurrentSnackBar = true,
    bool isWarningMessage = false,
  }) {
    final scaffoldMessengerState = scaffoldMessengerKey.currentState!;
    if (removeCurrentSnackBar) {
      scaffoldMessengerState.removeCurrentSnackBar();
    }
    scaffoldMessengerState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: isWarningMessage
                ? ThemeData().colorScheme.error
                : ThemeData().highlightColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
