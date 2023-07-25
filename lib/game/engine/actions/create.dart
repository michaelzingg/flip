import 'package:flip_flutter/game/engine/model/die.dart';
import 'package:flip_flutter/game/engine/model/game_state.dart';

import '../model/player.dart';

GameState create(int seed) {
  return const GameState([PlayedDie(1, 3)], Player.one, 5);
}
