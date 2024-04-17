import 'package:fpdart/fpdart.dart';

import '../model/die.dart';
import '../model/game_state.dart';

Either<String, GameState> flip(int dieId, GameState state) {
  return state.dice
      .where((element) => element.dieId == dieId)
      .firstOption
      .toEither(() => 'Die with id $dieId not found')
      .filterOrElse((r) => r is PlayerDie, (r) => 'Can only flip player dice')
      .filterOrElse((r) => r is UnflippedDie, (r) => 'Die already flipped')
      .map((a) => (a as UnflippedDie).flip())
      .map(state.replaceDie)
      .map(resetRecoverableEyes)
      .map(changeTurns);
}
