import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_data.freezed.dart';

@freezed
class GameData with _$GameData {
  const factory GameData({
    @Default({
      6: [(3, 1), (2, 2), (1, 3)],
      7: [(4, 1), (3, 1), (2, 2), (1, 3)],
      8: [(4, 1), (3, 2), (2, 3), (1, 3)],
      10: [(5, 1), (4, 1), (3, 2), (2, 3), (1, 4)],
      12: [(5, 1), (4, 1), (3, 2), (2, 4), (1, 4)],
      15: [(5, 1), (4, 2), (3, 3), (2, 4), (1, 4)],
    })
    Map<int, List<(int, int)>> shipSizes,
  }) = _GameData;
}
