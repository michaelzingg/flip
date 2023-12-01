import 'dart:math';

import 'package:fpdart/fpdart.dart';

State<Random, int> randomInt() {
  return State((Random rnd) {
    return (rnd.nextInt(1 << 32), rnd);
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
  return List.generate(
      numberOfElements,
      (_) => randomIntInRange(
          startInclusive: startInclusive,
          endExclusive: endExclusive)).sequence();
}

extension StateListSequence<S, A> on List<State<S, A>> {
  State<S, List<A>> sequence() {
    return foldRight(
        State((state) => ([], state)),
        (element, accumulator) =>
            element.map2(accumulator, (a, c) => [...a, c]));
  }
}

State<S, A> unit<S, A>(A a) => State((state) => (a, state));
