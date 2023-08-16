import 'package:flutter/widgets.dart';

import '../game/engine/model/die.dart';

class DiceWidget extends StatelessWidget {
  final Die die;

  const DiceWidget({super.key, required this.die});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Image(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/Dice-${die.value}.png')),
    );
  }
}
