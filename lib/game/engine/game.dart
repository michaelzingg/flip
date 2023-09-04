import 'package:flip_flutter/game/engine/actions/flip.dart';
import 'package:flip_flutter/game/engine/actions/play.dart';
import 'package:flip_flutter/game/engine/actions/recover.dart';
import 'package:flip_flutter/game/engine/model/die.dart';
import 'package:fpdart/fpdart.dart';

import 'model/game_state.dart';
import 'model/player.dart';

const dummyState = GameState(dice: [], turn: Player.one, recoverableEyes: 0);

Either<String, GameState> run(GameEvent event, GameState state) =>
    _processEvent(event).run(state).first;

State<GameState, Either<String, GameState>> _processEvent(GameEvent event) =>
    State<GameState, Either<String, GameState>>((GameState state) {
      // TODO: Try to write in a more functional way
      if (event.player != state.turn) {
        return Tuple2(Either.left('${state.turn.name}\'s turn'), state);
      }
      if (state.winner.toOption().isSome()) {
        return Tuple2(
            Either.left('Game ended. No more moves possible!'), state);
      }
      final newState = state.dice
          .where((t) => t.dieId == event.dieId)
          .firstOption
          .toEither(() => "die id not found")
          .flatMap((dieId) => _process(state, dieId));
      return Tuple2(newState, newState.getOrElse((l) => state));
    });

Either<String, GameState> _process(GameState state, Die die) => switch (die) {
      PlayerDie() when die.player == state.turn =>
        flip(die.dieId, state).map(_checkAndUpdateWinner),
      PlayerDie() => play(die.dieId, state).map(_checkAndUpdateWinner),
      PlayedDie() => recover(die.dieId, state)
    };

GameState _checkAndUpdateWinner(GameState state) => _getWinnerOptional(state)
    .map((winner) => GameState(
        dice: state.dice,
        turn: state.turn,
        recoverableEyes: state.recoverableEyes,
        winner: winner))
    .getOrElse(() => state);

Option<Player> _getWinnerOptional(GameState state) {
  if (!_containsPlayerDice(state.dice, Player.one)) {
    return const Option.of(Player.two);
  } else if (!_containsPlayerDice(state.dice, Player.two)) {
    return const Option.of(Player.one);
  } else {
    return const Option.none();
  }
}

bool _containsPlayerDice(Iterable<Die> dice, Player one) =>
    dice.any((element) => element is PlayerDie && element.player == one);
