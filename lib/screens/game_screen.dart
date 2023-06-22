import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/level.dart';
import '../providers/level_settings.dart';
import '../routing/routes.dart';
import '../widgets/board.dart';
import '../widgets/legend.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelSettings = ref.watch(levelSettingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battleships'),
        actions: [
          IconButton(
            onPressed: () {
              const HelpRoute().push(context);
            },
            icon: const Icon(Icons.help),
          )
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isPortrait = constraints.maxWidth < constraints.maxHeight;
            final boardWidth = min(
                switch (levelSettings.size) {
                  15 => 675.0,
                  12 => 600.0,
                  10 => 500.0,
                  8 => 400.0,
                  _ => 360.0,
                },
                (isPortrait ? constraints.maxWidth : constraints.maxHeight) -
                    80.0);
            if (isPortrait) {
              return Column(
                children: [
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Board(boardWidth: boardWidth),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 16.0),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Legend(boardWidth: boardWidth),
                        ),
                        const SizedBox(height: 32.0),
                        const _Buttons()
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Row(
                children: [
                  Flexible(
                    flex: 7,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Board(boardWidth: boardWidth),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const SizedBox(height: 20.0),
                        Legend(boardWidth: boardWidth),
                        const SizedBox(height: 8.0),
                        const _Buttons()
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ShowMistakesButton(),
        SizedBox(width: 8.0),
        _ResetButton(),
      ],
    );
  }
}

class _ShowMistakesButton extends StatelessWidget {
  const _ShowMistakesButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.ad_units_outlined),
      label: const Text('Show mistakes'),
    );
  }
}

class _ResetButton extends ConsumerWidget {
  const _ResetButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(levelProvider.notifier).reset();
      },
      child: const Text('Reset'),
    );
  }
}
