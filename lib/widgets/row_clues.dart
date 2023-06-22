import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/level_settings.dart';

class RowClues extends ConsumerWidget {
  const RowClues(this.generator, {super.key, required this.boardWidth});

  final double boardWidth;
  final Widget Function(int) generator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelSettings = ref.watch(levelSettingsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        height: boardWidth - 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(levelSettings.size, generator),
        ),
      ),
    );
  }
}
