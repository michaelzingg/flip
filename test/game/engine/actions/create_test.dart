import 'package:flip_flutter/game/engine/actions/create.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return same game state with same seeds', () async {
    expect(create(66), create(66));
  });
}
