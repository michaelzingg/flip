import '../model/game_state.dart';

typedef FlipAction = GameState Function(int dieId, GameState state);

// TODO implement flip() function