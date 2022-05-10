import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../dependency_injection.dart';
import '../../../../../../global/theme/app_themes.dart';
import '../../../../../../global/theme/bloc/theme_bloc.dart';

class ThemeSwitcherWidget extends StatelessWidget {
  final bool toggled;

  const ThemeSwitcherWidget({
    required this.toggled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ThemeBloc>(),
      child: SwitchListTile(
        title: const Text('Темная тема'),
        value: toggled,
        onChanged: (value) {
          final AppTheme appTheme;
          value
              ? appTheme = AppTheme.darkTheme
              : appTheme = AppTheme.lightTheme;
          BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(appTheme));
        },
      ),
    );
  }
}
