import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/row_remaining.dart';
import '../providers/tile_width.dart';
import 'remaining.dart';
import 'row_clues.dart';

class RowRemaining extends ConsumerWidget {
  const RowRemaining({super.key, required this.boardWidth});

  final double boardWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileWidth = ref.watch(tileWidthProvider(boardWidth));

    return RowClues(
      (index) => Remaining(
        ref.watch(rowRemainingProvider(row: index)),
        size: tileWidth,
      ),
      boardWidth: boardWidth,
    );
  }
}
