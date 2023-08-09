import 'package:equatable/equatable.dart';

import 'die.dart';
import 'player.dart';

final class GameState extends Equatable {
  final Iterable<Die> dice;
  final Player turn;
  final int recoverableEyes;
  final Player? winner;

  const GameState(
      {required this.dice,
      required this.turn,
      required this.recoverableEyes,
      this.winner});

  @override
  List<Object?> get props => [dice, turn, recoverableEyes, winner];
}

final class GameEvent extends Equatable {
  final Player player;
  final int dieId;

  const GameEvent(this.player, this.dieId);

  @override
  List<Object?> get props => [player, dieId];
}
