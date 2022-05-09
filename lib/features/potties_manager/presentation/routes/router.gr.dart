// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../../domain/entities/pot_set.dart' as _i6;
import '../pages/concrete_pot_set_overview_page.dart' as _i3;
import '../pages/pot_sets_overview_page.dart' as _i1;
import '../pages/settings_page.dart' as _i2;

class Router extends _i4.RootStackRouter {
  Router([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    PotSetsOverviewRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.PotSetsOverviewPage());
    },
    SettingsRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SettingsPage());
    },
    ConcretePotSetOverviewRoute.name: (routeData) {
      final args = routeData.argsAs<ConcretePotSetOverviewRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ConcretePotSetOverviewPage(
              potSet: args.potSet, key: args.key));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(PotSetsOverviewRoute.name, path: '/'),
        _i4.RouteConfig(SettingsRoute.name, path: '/settings-page'),
        _i4.RouteConfig(ConcretePotSetOverviewRoute.name,
            path: '/concrete-pot-set-overview-page')
      ];
}

/// generated route for
/// [_i1.PotSetsOverviewPage]
class PotSetsOverviewRoute extends _i4.PageRouteInfo<void> {
  const PotSetsOverviewRoute() : super(PotSetsOverviewRoute.name, path: '/');

  static const String name = 'PotSetsOverviewRoute';
}

/// generated route for
/// [_i2.SettingsPage]
class SettingsRoute extends _i4.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: '/settings-page');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i3.ConcretePotSetOverviewPage]
class ConcretePotSetOverviewRoute
    extends _i4.PageRouteInfo<ConcretePotSetOverviewRouteArgs> {
  ConcretePotSetOverviewRoute({required _i6.PotSet potSet, _i5.Key? key})
      : super(ConcretePotSetOverviewRoute.name,
            path: '/concrete-pot-set-overview-page',
            args: ConcretePotSetOverviewRouteArgs(potSet: potSet, key: key));

  static const String name = 'ConcretePotSetOverviewRoute';
}

class ConcretePotSetOverviewRouteArgs {
  const ConcretePotSetOverviewRouteArgs({required this.potSet, this.key});

  final _i6.PotSet potSet;

  final _i5.Key? key;

  @override
  String toString() {
    return 'ConcretePotSetOverviewRouteArgs{potSet: $potSet, key: $key}';
  }
}
