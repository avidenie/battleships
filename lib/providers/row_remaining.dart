import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/tile_model.dart';
import 'level.dart';
import 'level_settings.dart';
import 'tile_controller.dart';

part 'row_remaining.g.dart';

@riverpod
int rowRemaining(RowRemainingRef ref, int row) {
  final levelSettings = ref.watch(levelSettingsProvider);
  final level = ref.watch(levelProvider);
  final existing = List.generate(
    levelSettings.size,
    (index) => ref
                .watch(tileControllerProvider(
                    index: row * levelSettings.size + index))
                .current ==
            TileType.ship
        ? 1
        : 0,
  ).reduce((value, element) => value + element);

  return level.rowSums[row] - existing;
}
