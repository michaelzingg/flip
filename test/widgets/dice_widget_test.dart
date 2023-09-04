import 'package:flip_flutter/game/engine/model/die.dart';
import 'package:flip_flutter/widgets/dice_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DiceWidget renders properly', (tester) async {
    await tester.pumpWidget(DiceWidget(
      die: const PlayedDie(0, 1),
      onClickHandler: (x) => {},
    ));
  });
}
