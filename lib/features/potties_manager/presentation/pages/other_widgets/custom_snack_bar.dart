import 'package:flutter/material.dart';

SnackBar showCustomSnackBar(BuildContext context, String message) {
  final contextColorScheme = Theme.of(context).colorScheme;

  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(message),
    action: SnackBarAction(
      label: 'ОК',
      textColor: contextColorScheme.onSecondary,
      onPressed: () {},
    ),
    backgroundColor: contextColorScheme.primaryContainer,
  );
}
