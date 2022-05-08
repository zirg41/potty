import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:potty/ui/global/theme/app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(appThemeData[AppTheme.lightTheme]!)) {
    on<ThemeChanged>((event, emit) {
      emit(ThemeState(appThemeData[event.theme]!));
    });
  }
}
