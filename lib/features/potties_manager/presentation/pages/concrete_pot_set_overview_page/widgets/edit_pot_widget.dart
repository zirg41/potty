import 'package:flutter/material.dart';

class EditPotWidget extends StatelessWidget {
  const EditPotWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctxTheme = Theme.of(context);
    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.5,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        color: ctxTheme.colorScheme.surface,
        child: Container(
          height: 150,
          width: 100,
        ),
      ),
    );
  }
}
