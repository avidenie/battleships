import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'level_settings.dart';

part 'tile_width.g.dart';

@riverpod
double tileWidth(TileWidthRef ref, double boardWidth) {
  final levelSettings = ref.watch(levelSettingsProvider);
  final tileWidth =
      (boardWidth - 8 - (levelSettings.size - 1)) / levelSettings.size;
  return min(tileWidth, 35.0);
}
