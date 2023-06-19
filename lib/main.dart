import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'routing/routes.dart';

void main() {
  runApp(ProviderScope(child: GameApp()));
}

class GameApp extends StatelessWidget {
  GameApp({super.key});

  final _router = GoRouter(routes: $appRoutes);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Battleships',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
