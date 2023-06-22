import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/tile_model.dart';
import 'level.dart';
import 'level_settings.dart';
import 'tile_controller.dart';

part 'column_remaining.g.dart';

@riverpod
int columnRemaining(ColumnRemainingRef ref, int column) {
  final levelSettings = ref.watch(levelSettingsProvider);
  final level = ref.watch(levelProvider);
  final existing = List.generate(
    levelSettings.size,
    (index) => ref
                .watch(tileControllerProvider(
                    index: index * levelSettings.size + column))
                .current ==
            TileType.ship
        ? 1
        : 0,
  ).reduce((value, element) => value + element);

  return level.colSums[column] - existing;
}
