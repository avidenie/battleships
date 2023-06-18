import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'level.dart';
import 'row_remaining.dart';
import 'tile_controller.dart';

part 'row_sums.g.dart';

@riverpod
class RowSums extends _$RowSums {
  @override
  void build(int row) {}

  bool canFill() {
    return ref.read(rowRemainingProvider(row)) == 0;
  }

  void fill() {
    final remaining = ref.read(rowRemainingProvider(row));
    if (remaining == 0) {
      final size = ref.read(levelProvider).size;
      final tiles = List.generate(
        size,
        (index) => row * size + index,
      );
      for (final tile in tiles) {
        ref.read(tileControllerProvider(index: tile).notifier).fill();
      }
    }
  }
}
