import 'package:auto_route/auto_route.dart';
import '../pages/concrete_pot_set_overview_page/concrete_pot_set_overview_page.dart';
import '../pages/pot_sets_overview_page/pot_sets_overview_page.dart';
import '../pages/settings_page/settings_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: PotSetsOverviewPage, initial: true),
    AutoRoute(page: SettingsPage),
    AutoRoute(page: ConcretePotSetOverviewPage),
  ],
)
class $Router {}
