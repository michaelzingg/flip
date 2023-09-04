import 'package:flip_flutter/game/engine/game.dart';
import 'package:flip_flutter/game/engine/model/die.dart';
import 'package:flip_flutter/game/engine/model/game_state.dart';
import 'package:flip_flutter/game/engine/model/player.dart';
import 'package:flip_flutter/widgets/dice_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';

class GameWidget extends HookWidget {
  final GameState state;

  final Either<String, GameState> Function(GameEvent event, GameState state)
      runMethod;

  const GameWidget({super.key, required this.state, required this.runMethod});

  @override
  Widget build(BuildContext context) {
    final stateNotifier = useState(state);

    final sendGameEvent = (int dieId) =>
        run(GameEvent(stateNotifier.value.turn, dieId), stateNotifier.value)
            .fold((l) => print(l), (r) => stateNotifier.value = r);

    return Column(
      children: [
        Text('Player ${stateNotifier.value.turn.name} s turn'),
        const Text('Player 1'),
        Wrap(
          spacing: 8.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: stateNotifier.value.dice
              .whereType<PlayerDie>()
              .where((element) => element.player == Player.one)
              .map((e) => DiceWidget(
                    die: e,
                    onClickHandler: sendGameEvent,
                  ))
              .toList(),
        ),
        const Text('Played Dice'),
        SizedBox(
          height: 50,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.center,
            children: stateNotifier.value.dice
                .whereType<PlayedDie>()
                .map((e) => DiceWidget(
                      die: e,
                      onClickHandler: sendGameEvent,
                    ))
                .toList(),
          ),
        ),
        const Text('Player 2'),
        Wrap(
          spacing: 8.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: stateNotifier.value.dice
              .whereType<PlayerDie>()
              .where((element) => element.player == Player.two)
              .map((e) => DiceWidget(
                    die: e,
                    onClickHandler: sendGameEvent,
                  ))
              .toList(),
        ),
        Text(stateNotifier.value.winner
            .toOption()
            .map((t) => 'Player ${t.name} wins!')
            .getOrElse(() => 'Keep playing...'))
      ],
    );
  }
}
