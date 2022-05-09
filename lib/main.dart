import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/potties_manager/presentation/pages/settings_page.dart';
import 'global/theme/bloc/theme_bloc.dart';
import 'dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key = const ValueKey("root-widget")}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di.sl<ThemeBloc>()..add(const ThemeInitializationEvent()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Empty app',
            theme: state.themeData,
            home: const SettingsPage(),
          );
        },
      ),
    );
  }
}
