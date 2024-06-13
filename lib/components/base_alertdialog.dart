import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {
  final Widget child;
  final String? confirmText;
  final String? rejectText;
  final Color? actionButtonColor;
  final Color? backgroundColor;
  final Function() onClickConfirm;
  final Function() onClickReject;

  const BaseAlertDialog({
    super.key,
    required this.child,
    required this.onClickConfirm,
    required this.onClickReject,
    this.confirmText,
    this.rejectText,
    this.actionButtonColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      actionsPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      content: child,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: actionButtonColor,
          ),
          onPressed: onClickReject,
          child: Text(
            rejectText ?? "No",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: actionButtonColor,
          ),
          onPressed: onClickConfirm,
          child: Text(
            confirmText ?? "Yes",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}