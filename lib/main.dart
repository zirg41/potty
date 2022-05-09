import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potty/features/potties_manager/presentation/routes/router.gr.dart'
    as routes;
import 'dependency_injection.dart' as di;
import 'global/theme/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key = const ValueKey("root-widget")}) : super(key: key);

  final appRouter = di.sl<routes.Router>();

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
          return MaterialApp.router(
            theme: state.themeData,
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
