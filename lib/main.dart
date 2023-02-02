import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/pots_converter_to_new_version.dart';
import 'features/potties_manager/presentation/bloc/pots_actor/pots_bloc.dart';
import 'features/potties_manager/presentation/bloc/pots_watcher/pots_watcher_bloc.dart';
import 'package:potty/features/potties_manager/presentation/routes/router.gr.dart'
    as routes;
import 'dependency_injection.dart' as di;
import 'global/theme/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await convertOldPotSetToNewOne();
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
        BlocProvider(
          create: (context) =>
              di.sl<PotsWatcherBloc>()..add(const PotsWatcherGetAllPotsEvent()),
        ),
        BlocProvider(
          create: (context) => di.sl<PotsBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
