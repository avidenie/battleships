import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/column_remaining.dart';
import '../providers/column_sums.dart';
import '../providers/level.dart';
import '../providers/tile_width.dart';
import 'column_clues.dart';
import 'sum.dart';

class ColumnSums extends ConsumerWidget {
  const ColumnSums({super.key, required this.boardWidth});

  final double boardWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final tileWidth = ref.watch(tileWidthProvider(boardWidth));

    return ColumnClues(
      (index) => Sum(
        sum: level.colSums[index],
        remaining: ref.watch(columnRemainingProvider(index)),
        size: tileWidth,
        onTap: ref.watch(columnSumsProvider(index).notifier).canFill()
            ? () {
                ref.read(columnSumsProvider(index).notifier).fill();
              }
            : null,
      ),
      boardWidth: boardWidth,
    );
  }
}
