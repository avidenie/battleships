import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'column_remaining.dart';
import 'level_settings.dart';
import 'tile_controller.dart';

part 'column_sums.g.dart';

@riverpod
class ColumnSums extends _$ColumnSums {
  @override
  void build(int column) {}

  bool canFill() {
    return ref.read(columnRemainingProvider(column)) == 0;
  }

  void fill() {
    final remaining = ref.read(columnRemainingProvider(column));
    if (remaining == 0) {
      final size = ref.read(levelSettingsProvider).size;
      final tiles = List.generate(
        size,
        (index) => index * size + column,
      );
      for (final tile in tiles) {
        ref.read(tileControllerProvider(index: tile).notifier).fill();
      }
    }
  }
}
