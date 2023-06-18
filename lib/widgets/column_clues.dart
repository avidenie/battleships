import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/level.dart';
import '../providers/tile_width.dart';

class ColumnClues extends ConsumerWidget {
  const ColumnClues(this.generator, {super.key, required this.boardWidth});

  final double boardWidth;
  final Widget Function(int) generator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final tileWidth = ref.watch(tileWidthProvider(boardWidth));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: tileWidth),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SizedBox(
            width: boardWidth - 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                level.size,
                generator,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
