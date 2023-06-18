import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/tile_state.dart';
import 'level.dart';
import 'tile_controller.dart';

part 'column_remaining.g.dart';

@riverpod
int columnRemaining(ColumnRemainingRef ref, int column) {
  final level = ref.watch(levelProvider);
  final existing = List.generate(
    level.size,
    (index) => ref
                .watch(
                    tileControllerProvider(index: index * level.size + column))
                .current ==
            TileType.ship
        ? 1
        : 0,
  ).reduce((value, element) => value + element);

  return level.colSums[column] - existing;
}
