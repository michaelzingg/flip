import 'dart:math';

import 'package:flip/game_engine/utils/random.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return same randomInt with same seed', () {
    expect(randomInt().evaluate(Random(77)),
        equals(randomInt().evaluate(Random(77))));
  });

  test('should return random number in given range', () {
    const min = 0;
    const max = 1;
    expect(
        randomIntInRange(startInclusive: min, endExclusive: max)
            .evaluate(Random(77)),
        allOf(greaterThanOrEqualTo(min), lessThan(max)));
  });

  test('should return a list of random numbers in given range', () {
    const min = 0;
    const max = 3;
    const n = 100;
    expect(
        randomIntListInRange(
                numberOfElements: n, startInclusive: min, endExclusive: max)
            .evaluate(Random(77)),
        everyElement(allOf(greaterThanOrEqualTo(min), lessThan(max))));
  });
}
