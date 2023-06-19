import 'package:flutter/material.dart';

import '../routing/routes.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Battleships',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                const ChooseRoute().go(context);
              },
              child: const Text('New game'),
            ),
            ElevatedButton(
              onPressed: () {
                const HelpRoute().go(context);
              },
              child: const Text('How to play'),
            ),
            ElevatedButton(
              onPressed: () {
                const SettingsRoute().go(context);
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
