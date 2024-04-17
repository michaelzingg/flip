import 'package:flip/game_engine/actions/create.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return same game state with same seeds', () {
    expect(create(seed: 66), equals(create(seed: 66)));
  });

  test('should return random game state with different seeds', () {
    expect(create(seed: 77), isNot(equals(create(seed: 55))));
  });
}
