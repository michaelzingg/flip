import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../game/engine/model/die.dart';

class DiceWidget extends StatelessWidget {
  final Die die;

  final void Function(int) onClickHandler;

  const DiceWidget(
      {super.key, required this.die, required this.onClickHandler});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: GestureDetector(
        onTap: () => onClickHandler(die.dieId),
        child: Opacity(
          opacity: die is FlippedDie ? 0.5 : 1,
          child: Image(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/Dice-${die.value}.png')),
        ),
      ),
    );
  }
}
