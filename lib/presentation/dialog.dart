import 'package:flutter/material.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String title,
  String? message,
  required String okText,
  String cancelText = 'やめとく。',
  required Function function,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: SelectableText(
          title,
        ),
        content: message != null
            ? SelectableText(
                message,
              )
            : null,
        actions: [
          TextButton(
            child: Text(
              cancelText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              okText,
            ),
            onPressed: () async {
              final navigator = Navigator.of(context);
              await function();
              navigator.pop();
            },
          ),
        ],
      );
    },
  );
}
