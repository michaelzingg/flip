import 'package:flip_flutter/game/engine/model/die.dart';
import 'package:fpdart/fpdart.dart';

import 'model/game_state.dart';
import 'model/player.dart';

final dummyState = GameState([], Player.one, 5);

Either<String, GameState> run(GameEvent event, GameState state) =>
    _processEvent(event).run(state).first;

final _processEvent = (GameEvent event) {
  return State<GameState, Either<String, GameState>>((GameState state) {
    if (event.player != state.turn) {
      return Tuple2(Either.left("${event.player}'s turn"), state);
    }
    final newState = state.dice
        .where((t) => t.dieId == event.dieId)
        .firstOption
        .toEither(() => "die id not found")
        .flatMap((dieId) => _process(state, dieId));
    return Tuple2(newState, newState.getOrElse((l) => state));
  });
};

final _process = (GameState state, Die die) => switch (die) {
      PlayerDie() => _newMethod(state, die),
      PlayedDie() => Either<String, GameState>.right(dummyState)
    };

final _newMethod = (GameState state, PlayerDie die) {
  final action = state.turn == die.player ? 1 : 2;
  return Either<String, GameState>.right(dummyState);
};
