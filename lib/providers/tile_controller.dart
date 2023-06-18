import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/tile_state.dart';

part 'tile_controller.g.dart';

@riverpod
class TileController extends _$TileController {
  @override
  TileState build({required int index}) {
    return const TileState(initial: TileType.none, isClue: false);
  }

  void onTap() {
    if (state.isClue) {
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
    if (state.isClue) {
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
}
