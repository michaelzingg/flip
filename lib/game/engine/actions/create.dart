import 'package:flip_flutter/game/engine/model/die.dart';
import 'package:flip_flutter/game/engine/model/game_state.dart';
import 'package:flip_flutter/game/engine/utils/random.dart';
import 'package:fpdart/fpdart.dart';

import '../model/player.dart';

GameState create({required int seed, int numberOfDicePerPlayer = 5}) {
  final dice = randomIntListInRange(
          numberOfElements: numberOfDicePerPlayer * 2,
          startInclusive: 1,
          endExclusive: 7)
      .evaluate(seed)
      .mapWithIndex((int t, int index) =>
          UnflippedDie(index, t, isEven(index) ? Player.one : Player.two));
  return GameState(dice: dice, turn: Player.one, recoverableEyes: 0);
}

UnflippedDie generateDice(int t, int index) =>
    UnflippedDie(index, t, isEven(index) ? Player.one : Player.two);

bool isEven(int index) => index % 2 == 0;
