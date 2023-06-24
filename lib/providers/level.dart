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
    return switch (size) {
      6 => const LevelModel(
          board: [6, 9, 10, 12, 18, 22, 23, 30, 32, 35],
          revealed: [10, 35],
          rowSums: [0, 3, 1, 3, 0, 3],
          colSums: [4, 0, 1, 1, 2, 2],
        ),
      _ => const LevelModel(
          board: [
            12,
            31,
            46,
            51,
            52,
            53,
            57,
            58,
            61,
            70,
            76,
            80,
            81,
            85,
            112,
            113,
            114,
            115,
            116,
            122,
            123,
            124,
            125,
            133,
            142,
            153,
            161,
            165,
            168,
            180,
            183,
            193,
            195,
            208
          ],
          revealed: [31, 57, 81, 114, 124, 133, 161, 168],
          rowSums: [1, 0, 1, 6, 2, 4, 0, 5, 5, 1, 2, 2, 3, 2, 0],
          colSums: [3, 4, 1, 4, 1, 2, 2, 3, 2, 1, 3, 2, 2, 4, 0],
        ),
    };
  }

  void reset() {
    final size = ref.read(levelSettingsProvider).size;
    List.generate(size * size, (index) {
      ref.invalidate(tileControllerProvider(index: index));
    });
  }
}
