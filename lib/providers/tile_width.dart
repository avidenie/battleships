import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'level.dart';

part 'tile_width.g.dart';

@riverpod
double tileWidth(TileWidthRef ref, double boardWidth) {
  final level = ref.watch(levelProvider);
  final tileWidth = (boardWidth - 8 - (level.size - 1)) / level.size;
  return min(tileWidth, 35.0);
}
