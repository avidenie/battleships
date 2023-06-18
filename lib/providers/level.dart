import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/level_data.dart';
import 'tile_controller.dart';

part 'level.g.dart';

@riverpod
class Level extends _$Level {
  @override
  LevelData build() {
    return const LevelData(
      size: 6,
      grid: [1],
      rowSums: [3, 0, 2, 2, 2, 1, 3, 0, 2, 2, 2, 1, 3, 0, 2, 2, 2, 1],
      colSums: [3, 0, 4, 1, 2, 0, 3, 0, 4, 1, 2, 0, 3, 0, 4, 1, 2, 0],
    );
  }

  void reset() {
    List.generate(state.size * state.size, (index) {
      ref.read(tileControllerProvider(index: index).notifier).reset();
    });
  }
}
