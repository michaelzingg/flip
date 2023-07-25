import 'package:equatable/equatable.dart';

import 'player.dart';

sealed class Die extends Equatable {
  final int dieId;
  final int value;

  const Die(this.dieId, this.value);

  @override
  List<Object?> get props => [dieId, value];
}

sealed class PlayerDie extends Die {
  final Player player;

  const PlayerDie(super.dieId, super.value, this.player);

  PlayedDie play() => PlayedDie(dieId, value);

  @override
  List<Object?> get props => super.props..addAll([player]);
}

class FlippedDie extends PlayerDie {
  const FlippedDie(super.dieId, super.value, super.player);

  UnflippedDie unflip() => UnflippedDie(dieId, value, player);
}

class UnflippedDie extends PlayerDie {
  const UnflippedDie(super.dieId, super.value, super.player);

  FlippedDie flip() => FlippedDie(dieId, value, player);
}

class PlayedDie extends Die {
  const PlayedDie(super.dieId, super.value);

  UnflippedDie recover(Player player) => UnflippedDie(dieId, value, player);
}
