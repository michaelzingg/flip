import 'package:flip_game_engine/src/actions/recover.dart';
import 'package:flip_game_engine/src/model/die.dart';
import 'package:flip_game_engine/src/model/game_state.dart';
import 'package:flip_game_engine/src/model/player.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test/test.dart';

void main() {
  group('recover', () {
    test('should return state with recovered die', () {
      const testState = GameState(
          dice: [PlayedDie(0, 3)], turn: Player.one, recoverableEyes: 4);
      final result = recover(0, testState);
      expect(
          result
              .getRight()
              .getOrElse(
                  () => fail('Expected Either.right, but was Either.left'))
              .dice
              .filter((t) => t.dieId == 0)
              .first,
          isA<PlayerDie>());
    });

    // TODO: write more tests
  });
}
