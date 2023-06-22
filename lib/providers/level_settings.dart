import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/difficulty.dart';
import '../models/level_settings_model.dart';

part 'level_settings.g.dart';

@riverpod
class LevelSettings extends _$LevelSettings {
  static Map<int, List<(int, int)>> shipSizes = {
    6: [(3, 1), (2, 2), (1, 3)],
    8: [(4, 1), (3, 2), (2, 3), (1, 3)],
    10: [(4, 1), (3, 2), (2, 3), (1, 4)],
    12: [(5, 1), (4, 1), (3, 2), (2, 4), (1, 4)],
    15: [(5, 1), (4, 2), (3, 3), (2, 4), (1, 5)],
  };

  @override
  LevelSettingsModel build() {
    return const LevelSettingsModel(
      size: 6,
      difficulty: Difficulty.normal,
    );
  }

  void setSize(int size) {
    state = state.copyWith(size: size);
  }

  void setDifficulty(Difficulty difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }
}
