import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_data.dart';

part 'game.g.dart';

@riverpod
GameData game(GameRef ref) {
  return const GameData();
}
