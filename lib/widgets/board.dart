import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/level.dart';
import '../providers/tile_width.dart';
import 'column_remaining.dart';
import 'column_sums.dart';
import 'row_remaining.dart';
import 'row_sums.dart';
import 'tile.dart';

class Board extends ConsumerWidget {
  const Board({super.key, required this.boardWidth});

  final double boardWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final tileWidth = ref.watch(tileWidthProvider(boardWidth));

    return SizedBox(
      width: boardWidth + 2 * tileWidth,
      child: Column(
        children: [
          ColumnSums(boardWidth: boardWidth),
          Row(
            children: [
              RowSums(boardWidth: boardWidth),
              SizedBox(
                width: boardWidth,
                height: boardWidth,
                child: Container(
                  color: Colors.black,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(4.0),
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    crossAxisCount: level.size,
                    children: List.generate(level.size * level.size, (index) {
                      return Tile(index: index);
                    }),
                  ),
                ),
              ),
              RowRemaining(boardWidth: boardWidth),
            ],
          ),
          ColumnRemaining(boardWidth: boardWidth)
        ],
      ),
    );
  }
}
