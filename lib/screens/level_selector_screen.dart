import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/difficulty.dart';
import '../providers/level_settings.dart';
import '../routing/routes.dart';

class LevelSelectorScreen extends StatelessWidget {
  const LevelSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Size', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8.0),
                if (constraints.maxWidth > constraints.maxHeight)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: LevelSettings.shipSizes.keys
                        .map(
                          (size) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: SizeChoiceChip(size: size),
                          ),
                        )
                        .toList(growable: false),
                  )
                else
                  Column(
                    children: LevelSettings.shipSizes.keys
                        .map((size) => SizeChoiceChip(size: size))
                        .toList(growable: false),
                  ),
                const SizedBox(height: 16.0),
                Text('Difficulty',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DifficultyChoiceChip(difficulty: Difficulty.normal),
                    SizedBox(width: 8),
                    DifficultyChoiceChip(difficulty: Difficulty.hard),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    const GameRoute().go(context);
                  },
                  child: const Text('Play'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class DifficultyChoiceChip extends ConsumerWidget {
  const DifficultyChoiceChip({super.key, required this.difficulty});

  final Difficulty difficulty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelSettings = ref.watch(levelSettingsProvider);
    return ChoiceChip(
      label: Text(switch (difficulty) {
        Difficulty.normal => 'Normal',
        Difficulty.hard => 'Hard',
      }),
      selected: levelSettings.difficulty == difficulty,
      onSelected: (bool selected) {
        ref.read(levelSettingsProvider.notifier).setDifficulty(difficulty);
      },
    );
  }
}

class SizeChoiceChip extends ConsumerWidget {
  const SizeChoiceChip({super.key, required this.size});

  final int size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelSettings = ref.watch(levelSettingsProvider);
    return ChoiceChip(
      label: Text('${size}x$size'),
      selected: levelSettings.size == size,
      onSelected: (bool selected) {
        ref.read(levelSettingsProvider.notifier).setSize(size);
      },
    );
  }
}
