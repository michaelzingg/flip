import 'player.dart';

sealed class Die {
  final int dieId;
  final int value;

  Die(this.dieId, this.value);
}

sealed class PlayerDie extends Die {
  final Player player;

  PlayerDie(super.dieId, super.value, this.player);

  PlayedDie play() => PlayedDie(dieId, value);
}

class FlippedDie extends PlayerDie {
  FlippedDie(super.dieId, super.value, super.player);

  UnflippedDie unflip() => UnflippedDie(dieId, value, player);
}

class UnflippedDie extends PlayerDie {
  UnflippedDie(super.dieId, super.value, super.player);

  FlippedDie flip() => FlippedDie(dieId, value, player);
}

class PlayedDie extends Die {
  PlayedDie(super.dieId, super.value);

  UnflippedDie recover(Player player) => UnflippedDie(dieId, value, player);
}
