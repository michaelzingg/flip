import 'package:fpdart/fpdart.dart';

import '../model/die.dart';
import '../model/game_state.dart';

Either<String, GameState> play(int dieId, GameState state) {
  isOponentDie(PlayerDie die) => die.player != state.turn;

  return state.dice
      .where((die) => die.dieId == dieId)
      .firstOption
      .toEither(() => 'Die with id $dieId not found')
      .filterOrElse(_isPlayerDie, (_) => 'Can only play player dice')
      .map(_toPlayerDie)
      .filterOrElse(isOponentDie, (_) => 'Can only play oponent dice')
      .map((die) => die.play())
      .map(state.replaceDie)
      .map(_resetFlippedDice)
      .map(_setRecoverableEyes(dieId))
      .map(changeTurns);
}

bool _isPlayerDie(Die die) => die is PlayerDie;

PlayerDie _toPlayerDie(Die die) => die as PlayerDie;

GameState Function(GameState state) _setRecoverableEyes(int dieId) =>
    (GameState state) => GameState(
        dice: state.dice,
        turn: state.turn,
        recoverableEyes: state.dice
            .where((die) => die.dieId == dieId)
            .firstOption
            .map((t) => t.value - 1)
            .getOrElse(() => 0));

GameState _resetFlippedDice(GameState state) => GameState(
    dice: state.dice
        .map((e) => e is FlippedDie && e.player == state.turn ? e.unflip() : e),
    turn: state.turn,
    recoverableEyes: state.recoverableEyes);
