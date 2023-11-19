import 'package:flip_game_engine/src/actions/create.dart';
import 'package:test/test.dart';

void main() {
  test('should return same game state with same seeds', () {
    expect(create(seed: 66), equals(create(seed: 66)));
  });

  test('should return random game state with different seeds', () {
    expect(create(seed: 77), isNot(equals(create(seed: 55))));
  });
}
