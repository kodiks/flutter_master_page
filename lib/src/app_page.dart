// library app_page;

import 'package:flutter/material.dart';

/// Main pages data model
class AppPage {
  /// Name must be uniq
  final String name;
  final PageRoute route;
  final IconData icon;

  /// Title shown on bottom navigation bar
  final String title;
  GlobalKey<NavigatorState> navigatorKey;
  RouteObserver<PageRoute> routeObserver;

  AppPage({
    @required this.name,
    @required this.route,
    @required this.title,
    GlobalKey<NavigatorState> navigatorKey,
    RouteObserver<PageRoute> routeObserver,
    this.icon,
  }) {
    this.navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();
    this.routeObserver = routeObserver ?? RouteObserver<PageRoute>();
  }
}
