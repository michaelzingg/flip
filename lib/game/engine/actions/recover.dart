import '../model/game_state.dart';

typedef RecoverAction = GameState Function(int dieId, GameState state);

// TODO implement recover() function