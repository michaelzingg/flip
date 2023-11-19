import 'package:flip/widgets/dice_widget.dart';
import 'package:flip_game_engine/flip_game_engine.dart';
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
            const Duration(milliseconds: 400),
            () => showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (context) => Dialog(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.emoji_events,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 15),
                          Text('${stateNotifier.value.winner?.name} wins!'),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
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
