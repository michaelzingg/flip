import 'package:flip/game_engine/model/die.dart';
import 'package:flip/widgets/dice_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DiceWidget renders properly', (tester) async {
    await tester.pumpWidget(
      wrap(
        child: DiceWidget(
          die: const PlayedDie(0, 1),
          onClickHandler: (x) => {},
        ),
      ),
    );
  });
}

Widget wrap({required Widget child}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Material(
      child: Center(child: child),
    ),
  );
}
