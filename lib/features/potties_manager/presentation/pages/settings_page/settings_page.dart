import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global/theme/app_themes.dart';
import '../../../../../global/theme/bloc/theme_bloc.dart';
import 'widgets/theme_switcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        bloc: BlocProvider.of<ThemeBloc>(context),
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ThemeSwitcherWidget(
                  toggled: appThemeData.keys.firstWhere(
                              (key) => appThemeData[key] == state.themeData) ==
                          AppTheme.darkTheme
                      ? true
                      : false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
