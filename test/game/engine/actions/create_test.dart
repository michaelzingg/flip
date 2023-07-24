import 'package:flip_flutter/game/engine/actions/create.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return same game state with same seeds', () async {
    // TODO: check full state and not only the winner
    expect(create(77).winner, equals(create(77).winner));
  });
}
