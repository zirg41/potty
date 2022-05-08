import 'package:flutter/material.dart';
import 'dependency_injection.dart' as di;
import 'features/potties_manager/presentation/pages/pot_sets_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key = const ValueKey("root-widget")}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empty app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PotSetsPage(),
    );
  }
}
