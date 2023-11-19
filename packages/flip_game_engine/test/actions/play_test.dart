import 'package:flip_game_engine/src/actions/create.dart';
import 'package:flip_game_engine/src/actions/play.dart';
import 'package:flip_game_engine/src/model/die.dart';
import 'package:flip_game_engine/src/model/game_state.dart';
import 'package:flip_game_engine/src/model/player.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test/test.dart';

void main() {
  final testDice = create(seed: 77).dice;
  group('play', () {
    test('should return state with played die', () {
      final testState =
          GameState(dice: testDice, turn: Player.one, recoverableEyes: 0);
      final result = play(1, testState);
      expect(
          result
              .getRight()
              .getOrElse(
                  () => fail('Expected Either.right, but was Either.left'))
              .dice
              .filter((t) => t.dieId == 1)
              .first,
          isA<PlayedDie>());
    });

    // TODO: write more tests
  });
}
