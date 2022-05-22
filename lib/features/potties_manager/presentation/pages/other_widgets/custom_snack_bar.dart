import 'package:flutter/material.dart';

SnackBar showCustomSnackBar(BuildContext context, String message) {
  final contextTheme = Theme.of(context);

  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: contextTheme.textTheme.bodyMedium
          ?.copyWith(color: contextTheme.colorScheme.onSecondary),
    ),
    action: SnackBarAction(
      label: 'ОК',
      textColor: contextTheme.colorScheme.onSecondary,
      onPressed: () {},
    ),
    backgroundColor: contextTheme.colorScheme.primaryContainer,
  );
}
