import 'package:flip_flutter/game/engine/model/die.dart';
import 'package:flip_flutter/game/engine/model/player.dart';
import 'package:fpdart/fpdart.dart';

import '../model/game_state.dart';

typedef FlipAction = Either<String, GameState> Function(
    int dieId, GameState state);

final FlipAction flip = (int dieId, GameState state) {
  return state.dice
      .where((element) => element.dieId == dieId)
      .firstOption
      .toEither(() => 'Die with id $dieId not found')
      .filterOrElse((r) => r is PlayerDie, (r) => 'Can only flip player dice')
      .filterOrElse((r) => r is UnflippedDie, (r) => 'Die already flipped')
      .map((a) => flipDie(a as UnflippedDie))
      .map(replaceDie(state))
      .map(resetRecoverableEyes)
      .map(changeTurns);
};

FlippedDie flipDie(UnflippedDie die) {
  return FlippedDie(die.dieId, die.value, die.player);
}

final replaceDie = (GameState state) {
  return (FlippedDie die) => GameState(
      dice: state.dice.map((e) => e.dieId == die.dieId ? die : e),
      turn: state.turn,
      recoverableEyes: state.recoverableEyes);
};

GameState resetRecoverableEyes(GameState state) {
  return GameState(dice: state.dice, turn: state.turn, recoverableEyes: 0);
}

GameState changeTurns(GameState state) {
  return GameState(
      dice: state.dice,
      turn: state.turn == Player.one ? Player.two : Player.one,
      recoverableEyes: state.recoverableEyes);
}
