import '../model/game_state.dart';

typedef PlayAction = GameState Function(int dieId, GameState state);

// TODO implement play() function