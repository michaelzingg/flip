import 'package:flip_flutter/game/engine/model/die.dart';
import 'package:flip_flutter/game/engine/model/game_state.dart';
import 'package:flip_flutter/game/engine/model/player.dart';
import 'package:flip_flutter/widgets/dice_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';

class GameWidget extends HookWidget {
  final GameState state;

  const GameWidget({super.key, required this.state});

  // TODO: Make dice clickable

  @override
  Widget build(BuildContext context) {
    final stateNotifier = useState(state);

    return Container(
        child: Column(
      children: [
        const Text('Player 1'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: stateNotifier.value.dice
              .whereType<PlayerDie>()
              .where((element) => element.player == Player.one)
              .map((e) => DiceWidget(
                    die: e,
                  ))
              .toList(),
        ),
        const Text('Played Dice'),
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: stateNotifier.value.dice
                .whereType<PlayedDie>()
                .map((e) => DiceWidget(
                      die: e,
                    ))
                .toList(),
          ),
        ),
        const Text('Player 2'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: stateNotifier.value.dice
              .whereType<PlayerDie>()
              .where((element) => element.player == Player.two)
              .map((e) => DiceWidget(
                    die: e,
                  ))
              .toList(),
        ),
        Text(stateNotifier.value.winner
            .toOption()
            .map((t) => 'Player ${t.name} wins!')
            .getOrElse(() => 'Keep playing...'))
      ],
    ));
  }
}
