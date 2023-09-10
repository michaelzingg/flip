import 'package:flutter/material.dart';

import 'dice_widget.dart';

class DiceAreaWidget extends StatelessWidget {
  final Iterable<DiceWidget> dice;
  final String playerName;

  const DiceAreaWidget(
      {super.key, required this.playerName, required this.dice});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(playerName),
          Expanded(
            child: Center(
              child: Wrap(
                  spacing: 8.0,
                  runSpacing: 12.0,
                  alignment: WrapAlignment.center,
                  children: dice.toList()),
            ),
          )
        ],
      ),
    );
  }
}
