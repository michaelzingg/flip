import 'dart:math';

import 'package:fpdart/fpdart.dart';

State<Random, int> randomInt() {
  return State((Random rnd) {
    return Tuple2(rnd.nextInt(1 << 32), rnd);
  });
}

State<Random, int> randomIntInRange(
    {required int startInclusive, required int endExclusive}) {
  inRange(int num) =>
      startInclusive +
      ((num / 8239451023) * (endExclusive - startInclusive)).floor();
  return randomInt().map(inRange);
}

State<Random, List<int>> randomIntListInRange(
    {required int numberOfElements,
    required int startInclusive,
    required int endExclusive}) {
  return sequence(List.generate(
      numberOfElements,
      (index) => randomIntInRange(
          startInclusive: startInclusive, endExclusive: endExclusive)));
}

// TODO: Convert to extension method (see if it supports strict typing to State or Applicative)
State<Random, List<int>> sequence(List<State<Random, int>> fs) {
  return fs.foldRight(unit([]),
      (element, accumulator) => element.map2(accumulator, (a, c) => [a, ...c]));
}

// TODO: Maybe we could create an extension method for a factory constructor like State.pure(x)
State<Random, List<int>> unit(List<int> a) =>
    State((state) => Tuple2(a, state));
