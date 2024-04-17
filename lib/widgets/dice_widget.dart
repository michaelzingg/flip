import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/material.dart';

import '../game_engine/model/die.dart';

class DiceWidget extends StatelessWidget {
  final Die die;

  final void Function(int) onClickHandler;

  const DiceWidget(
      {super.key, required this.die, required this.onClickHandler});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 40,
        color: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(die is FlippedDie ? 0.6 : 1),
        onPressed: () => onClickHandler(die.dieId),
        icon: Icon(_diceIconFromInt(die.value)));
  }
}

IconData _diceIconFromInt(int value) => switch (value) {
      1 => DiceIcons.dice1,
      2 => DiceIcons.dice2,
      3 => DiceIcons.dice3,
      4 => DiceIcons.dice4,
      5 => DiceIcons.dice5,
      6 => DiceIcons.dice6,
      _ => DiceIcons.dice0
    };
