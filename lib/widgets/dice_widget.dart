import 'package:flutter/widgets.dart';

class DiceWidget extends StatelessWidget {
  final int value;

  const DiceWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage('assets/images/Dice-$value.png'));
  }
}
