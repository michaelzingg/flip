import 'die.dart';
import 'player.dart';

final class GameState {
  final Iterable<Die> dice;
  final Player turn;
  final int recoverableEyes;
  final Player? winner;

  GameState(this.dice, this.turn, this.recoverableEyes, [this.winner]);
}

final class GameEvent {
  final Player player;
  final int dieId;

  GameEvent(this.player, this.dieId);
}
