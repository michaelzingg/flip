import 'package:flip/game/engine/game.dart';
import 'package:flip/game/engine/model/die.dart';
import 'package:flip/game/engine/model/game_state.dart';
import 'package:flip/game/engine/model/player.dart';
import 'package:flip/widgets/dice_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';

class GameWidget extends HookWidget {
  final GameState state;

  const GameWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final stateNotifier = useState(state);

    useValueChanged(
        stateNotifier.value.winner,
        (oldValue, oldResult) => Future.delayed(
            const Duration(milliseconds: 700),
            () => showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (context2) => Dialog(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('${stateNotifier.value.winner} wins!'),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.popUntil(
                                  context2, (route) => route.isFirst);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      ),
                    )))));

    final sendGameEvent = (int dieId) =>
        run(GameEvent(stateNotifier.value.turn, dieId), stateNotifier.value)
            .fold((l) {}, (r) => stateNotifier.value = r);

    return Scaffold(
      body: Center(
        child: Column(
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
        ),
      ),
    );
  }
}
