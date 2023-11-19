import 'package:flip_game_engine/flip_game_engine.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test/test.dart';

void main() {
  final testState = create(seed: 77);
  group('flip', () {
    test(
        'should return error if player 2 attempts to play when it is player 1\'s turn',
        () {
      final result = run(const GameEvent(Player.two, 0), testState);
      expect(
          result.getLeft().getOrElse(
              () => fail('Expected Either.left, but was Either.right')),
          equals('Player 1\'s turn'));
    });

    // TODO: write more tests
  });
}
