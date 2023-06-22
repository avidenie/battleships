import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/tile_model.dart';
import 'level.dart';

part 'tile_controller.g.dart';

@riverpod
class TileController extends _$TileController {
  @override
  TileModel build({required int index}) {
    final level = ref.watch(levelProvider);
    final revealed = level.revealed.contains(index);
    final initial = level.board.contains(index)
        ? TileType.ship
        : revealed
            ? TileType.water
            : TileType.none;
    return TileModel(
      initial: initial,
      revealed: revealed,
      current: revealed ? initial : TileType.none,
    );
  }

  void onTap() {
    if (state.revealed) {
      return;
    }

    switch (state.current) {
      case TileType.none:
        state = state.copyWith(current: TileType.water);
      case TileType.water:
        state = state.copyWith(current: TileType.ship);
      case TileType.ship:
        state = state.copyWith(current: TileType.none);
    }
  }

  void onLongPress() {
    if (state.revealed) {
      return;
    }

    switch (state.current) {
      case TileType.none:
        state = state.copyWith(current: TileType.ship);
      case TileType.water:
        state = state.copyWith(current: TileType.ship);
      case TileType.ship:
        state = state.copyWith(current: TileType.none);
    }
  }

  void onDrag() {
    if (state.revealed) {
      return;
    }

    switch (state.current) {
      case TileType.none:
        state = state.copyWith(current: TileType.water);
      case TileType.water:
        state = state.copyWith(current: TileType.ship);
      case TileType.ship:
    }
  }

  void fill() {
    if (!state.revealed && state.current == TileType.none) {
      state = state.copyWith(current: TileType.water);
    }
  }
}
