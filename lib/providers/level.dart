import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/difficulty.dart';
import '../models/level_model.dart';
import 'level_settings.dart';
import 'tile_controller.dart';

part 'level.g.dart';

@riverpod
class Level extends _$Level {
  @override
  LevelModel build() {
    final levelSettings = ref.watch(levelSettingsProvider);
    return _generate(levelSettings.size, levelSettings.difficulty);
  }

  LevelModel _generate(int size, Difficulty difficulty) {
    return const LevelModel(
      board: [0, 1, 2, 14, 20, 26],
      revealed: [1, 3, 14, 26],
      rowSums: [3, 0, 2, 2, 2, 1, 3, 0, 2, 2, 2, 1, 3, 0, 2, 2, 2, 1],
      colSums: [3, 0, 4, 1, 2, 0, 3, 0, 4, 1, 2, 0, 3, 0, 4, 1, 2, 0],
    );
  }

  void reset() {
    final size = ref.read(levelSettingsProvider).size;
    List.generate(size * size, (index) {
      ref.invalidate(tileControllerProvider(index: index));
    });
  }
}
