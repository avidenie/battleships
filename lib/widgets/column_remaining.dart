import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/column_remaining.dart';
import '../providers/tile_width.dart';
import 'column_clues.dart';
import 'remaining.dart';

class ColumnRemaining extends ConsumerWidget {
  const ColumnRemaining({super.key, required this.boardWidth});

  final double boardWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileWidth = ref.watch(tileWidthProvider(boardWidth));

    return ColumnClues(
      (index) => Remaining(
        ref.watch(columnRemainingProvider(column: index)),
        size: tileWidth,
      ),
      boardWidth: boardWidth,
    );
  }
}
