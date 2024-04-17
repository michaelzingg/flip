import 'dart:math';

import 'package:fpdart/fpdart.dart';

import '../model/die.dart';
import '../model/game_state.dart';
import '../model/player.dart';
import '../utils/random.dart';

GameState create({required int seed, int numberOfDicePerPlayer = 5}) {
  final dice = randomIntListInRange(
          numberOfElements: numberOfDicePerPlayer * 2,
          startInclusive: 1,
          endExclusive: 7)
      .evaluate(Random(seed))
      .mapWithIndex(_generateDice);
  return GameState(dice: dice, turn: Player.one, recoverableEyes: 0);
}

UnflippedDie _generateDice(int t, int index) =>
    UnflippedDie(index, t, _isEven(index) ? Player.one : Player.two);

bool _isEven(int index) => index % 2 == 0;
