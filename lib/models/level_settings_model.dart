import 'package:freezed_annotation/freezed_annotation.dart';

import 'difficulty.dart';

part 'level_settings_model.freezed.dart';

@freezed
class LevelSettingsModel with _$LevelSettingsModel {
  const factory LevelSettingsModel({
    required int size,
    required Difficulty difficulty,
  }) = _LevelSettingsModel;
}
