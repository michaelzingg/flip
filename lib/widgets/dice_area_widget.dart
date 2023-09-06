import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dice_widget.dart';

class DiceAreaWidget extends StatelessWidget {
  final Iterable<DiceWidget> dice;
  final String playerName;

  const DiceAreaWidget(
      {super.key, required this.playerName, required this.dice});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: [
            Text(playerName),
            Wrap(
                spacing: 8.0,
                runSpacing: 12.0,
                alignment: WrapAlignment.center,
                children: dice.toList()),
          ],
        ));
  }
}
