import 'package:flip/game/engine/game.dart';
import 'package:flip/game/engine/model/die.dart';
import 'package:flip/game/engine/model/game_state.dart';
import 'package:flip/game/engine/model/player.dart';
import 'package:flip/widgets/dice_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'dice_area_widget.dart';

class GameScreen extends HookWidget {
  final GameState state;

  const GameScreen({super.key, required this.state});

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

    final GameState Function(int dieId) sendGameEvent = (int dieId) =>
        run(GameEvent(stateNotifier.value.turn, dieId), stateNotifier.value)
            .fold((l) => stateNotifier.value, (r) => stateNotifier.value = r);

    final mapToDiceWidget = (
            {required GameState Function(int) onClickHandler}) =>
        (Die die) => DiceWidget(die: die, onClickHandler: onClickHandler);

    final List<DiceWidget> Function(Iterable<Die> dice, Player player)
        getDiceWidgetsFor = (Iterable<Die> dice, Player player) => dice
            .whereType<PlayerDie>()
            .where((element) => element.player == player)
            .map(mapToDiceWidget(onClickHandler: sendGameEvent))
            .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                'Player ${stateNotifier.value.turn.name} s turn',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              DiceAreaWidget(
                  playerName: 'Player 1',
                  dice:
                      getDiceWidgetsFor(stateNotifier.value.dice, Player.one)),
              DiceAreaWidget(
                playerName: 'Played Dice',
                dice: stateNotifier.value.dice
                    .whereType<PlayedDie>()
                    .map(mapToDiceWidget(onClickHandler: sendGameEvent))
                    .toList(),
              ),
              DiceAreaWidget(
                  playerName: 'Player 2',
                  dice:
                      getDiceWidgetsFor(stateNotifier.value.dice, Player.two)),
            ],
          ),
        ),
      ),
    );
  }
}
