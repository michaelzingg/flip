import 'package:fpdart/fpdart.dart';

import '../model/die.dart';
import '../model/game_state.dart';

typedef RecoverAction = Either<String, GameState> Function(
    int dieId, GameState state);

final RecoverAction recover = (int dieId, GameState state) => state.dice
    .where((die) => die.dieId == dieId)
    .firstOption
    .toEither(() => 'Die with id $dieId not found')
    .filterOrElse(
        (die) => die is PlayedDie, (_) => 'Can only recover played dice')
    .filterOrElse((die) => die.value <= state.recoverableEyes,
        (_) => 'Total recovering dice eyes must be less than thrashed die eyes')
    .map((a) => (a as PlayedDie).recover(state.turn))
    .map(state.replaceDie)
    .map(_updateRecoverableEyes(dieId));

final _updateRecoverableEyes = (int recoveredDieId) => (GameState state) =>
    GameState(
        dice: state.dice,
        turn: state.turn,
        recoverableEyes: state.recoverableEyes -
            state.dice
                .where((die) => die.dieId == recoveredDieId)
                .map((die) => die.value)
                .firstOption
                .getOrElse(() => 0));
