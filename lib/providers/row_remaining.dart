import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/tile_state.dart';
import 'level.dart';
import 'tile_controller.dart';

part 'row_remaining.g.dart';

@riverpod
int rowRemaining(RowRemainingRef ref, int row) {
  final level = ref.watch(levelProvider);
  final existing = List.generate(
    level.size,
    (index) => ref
                .watch(tileControllerProvider(index: row * level.size + index))
                .current ==
            TileType.ship
        ? 1
        : 0,
  ).reduce((value, element) => value + element);

  return level.rowSums[row] - existing;
}
