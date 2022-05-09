import 'package:auto_route/auto_route.dart';
import 'package:potty/features/potties_manager/presentation/pages/concrete_pot_set_overview_page.dart';
import 'package:potty/features/potties_manager/presentation/pages/pot_sets_overview_page.dart';
import 'package:potty/features/potties_manager/presentation/pages/settings_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: PotSetsOverviewPage, initial: true),
    AutoRoute(page: SettingsPage),
    AutoRoute(page: ConcretePotSetOverviewPage),
  ],
)
class $Router {}
