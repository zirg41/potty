import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  SharedPreferences sharedPreferences;
  ThemeBloc({required this.sharedPreferences})
      : super(ThemeState(appThemeData[AppTheme.lightTheme]!)) {
    on<ThemeChanged>((event, emit) async {
      emit(ThemeState(appThemeData[event.theme]!));
      await sharedPreferences.setString('theme', event.theme.toString());
    });
    on<ThemeInitializationEvent>(
      (_, emit) {
        final chosenTheme = sharedPreferences.getString('theme');
        if (chosenTheme is String) {
          AppTheme appTheme = AppTheme.values
              .firstWhere((element) => element.toString() == chosenTheme);
          emit(ThemeState(appThemeData[appTheme]!));
        }
        if (chosenTheme == null) {
          emit(ThemeState(appThemeData[AppTheme.lightTheme]!));
        }
      },
    );
  }
}
