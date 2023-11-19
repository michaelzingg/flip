/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

export 'src/actions/create.dart' show create;
export 'src/actions/flip.dart' show flip;
export 'src/actions/play.dart' show play;
export 'src/actions/recover.dart' show recover;
export 'src/game.dart' show run;
export 'src/model/die.dart'
    show Die, PlayerDie, PlayedDie, FlippedDie, UnflippedDie;
export 'src/model/game_state.dart' show GameState, GameEvent;
export 'src/model/player.dart' show Player;
