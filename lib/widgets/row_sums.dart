import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/level.dart';
import '../providers/row_remaining.dart';
import '../providers/tile_width.dart';
import 'row_clues.dart';
import 'sum.dart';

class RowSums extends ConsumerWidget {
  const RowSums({super.key, required this.boardWidth});

  final double boardWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final tileWidth = ref.watch(tileWidthProvider(boardWidth));

    return RowClues(
      (index) => Sum(
        sum: level.rowSums[index],
        remaining: ref.watch(rowRemainingProvider(row: index)),
        size: tileWidth,
      ),
      boardWidth: boardWidth,
    );
  }
}
