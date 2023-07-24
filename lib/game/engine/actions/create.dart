import 'package:flip_flutter/game/engine/model/game_state.dart';

import '../model/player.dart';

// TODO implement create() function
GameState create(int seed) {
  return GameState([], Player.one, 5);
}
