import 'package:freezed_annotation/freezed_annotation.dart';

part 'tile_state.freezed.dart';

enum TileType { none, water, ship }

@freezed
class TileState with _$TileState {
  const factory TileState({
    required final TileType initial,
    required final bool isClue,
    @Default(TileType.none) TileType current,
  }) = _TileState;
}
