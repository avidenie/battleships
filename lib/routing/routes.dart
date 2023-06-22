import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/level_selector_screen.dart';
import '../screens/help_screen.dart';
import '../screens/main_menu_screen.dart';
import '../screens/game_screen.dart';
import '../screens/settings_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<MainMenuRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<ChooseRoute>(
      path: 'choose',
    ),
    TypedGoRoute<GameRoute>(
      path: 'play',
    ),
    TypedGoRoute<HelpRoute>(
      path: 'how-to-play',
    ),
    TypedGoRoute<SettingsRoute>(
      path: 'settings',
    )
  ],
)
class MainMenuRoute extends GoRouteData {
  const MainMenuRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MainMenuScreen();
}

class ChooseRoute extends GoRouteData {
  const ChooseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LevelSelectorScreen();
}

class GameRoute extends GoRouteData {
  const GameRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const GameScreen();
}

class HelpRoute extends GoRouteData {
  const HelpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HelpScreen();
}

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}
