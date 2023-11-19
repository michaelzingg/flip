import 'package:fpdart/fpdart.dart';

State<int, int> randomInt() {
  return State((int seed) {
    final nextSeed = (1839567234 * seed + 972348567) % 8239451023;
    return Tuple2(nextSeed, nextSeed);
  });
}

State<int, int> randomIntInRange(
    {required int startInclusive, required int endExclusive}) {
  final inRange = (int num) =>
      startInclusive +
      ((num / 8239451023) * (endExclusive - startInclusive)).floor();
  return randomInt().map(inRange);
}

State<int, List<int>> randomIntListInRange(
    {required int numberOfElements,
    required int startInclusive,
    required int endExclusive}) {
  return sequence(List.generate(
      numberOfElements,
      (index) => randomIntInRange(
          startInclusive: startInclusive, endExclusive: endExclusive)));
}

// TODO: Convert to extension method (see if it supports strict typing to State or Applicative)
State<int, List<int>> sequence(List<State<int, int>> fs) {
  return fs.foldRight(unit([]),
      (element, accumulator) => element.map2(accumulator, (a, c) => [a, ...c]));
}

// TODO: Maybe we could create an extension method for a factory constructor like State.pure(x)
State<int, List<int>> unit(List<int> a) => State((state) => Tuple2(a, state));
