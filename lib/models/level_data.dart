import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_data.freezed.dart';

@freezed
class LevelData with _$LevelData {
  const factory LevelData({
    required int size,
    required List<int> grid,
    required List<int> rowSums,
    required List<int> colSums,
  }) = _LevelData;
}
