import 'package:flip/game_engine/actions/create.dart';
import 'package:flip/game_engine/actions/flip.dart';
import 'package:flip/game_engine/model/die.dart';
import 'package:flip/game_engine/model/game_state.dart';
import 'package:flip/game_engine/model/player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  final testDice = create(seed: 77).dice;
  group('flip', () {
    test('should return state with flipped die for player one', () {
      final testState =
          GameState(dice: testDice, turn: Player.one, recoverableEyes: 0);
      final result = flip(0, testState);
      expect(
          result
              .getRight()
              .getOrElse(
                  () => fail('Expected Either.right, but was Either.left'))
              .dice
              .filter((t) => t.dieId == 0)
              .first,
          isA<FlippedDie>());
    });

    // TODO: write more tests
  });
}
