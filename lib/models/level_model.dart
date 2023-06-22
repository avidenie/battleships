import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_model.freezed.dart';

@freezed
class LevelModel with _$LevelModel {
  const factory LevelModel({
    required List<int> board,
    required List<int> revealed,
    required List<int> rowSums,
    required List<int> colSums,
  }) = _LevelModel;
}
