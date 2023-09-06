![Flutter Test](https://github.com/michaelzingg/flip/actions/workflows/flutter_test.yml/badge.svg)

# FL!P

A die game for 2 Players.

## The Project

I started this hobby project to learn more about writing mobile applications, and Flutter seemed to be an interesting choice. Also, I took the opportunity to try out functional programming paradigms in practice and tried to apply them wherever possible (I took a few shortcuts and left some things to refactor for later). Right now the goal is also not just to provide a working application, but also try out the tooling and frameworks that would be used for a bigger project.

This is a work in progress. Any input and/or feedback is highly appreciated.

### Ideas for Features and Improvements

- UI definitely needs to be improved

  - Look and feel in general
  - Show hints on forbidden moves
  - Device specific UI
  - Add rule book
  - Animations. E.g., for flipping or moving die or dice role on start of the game.

- Test coverage. I developed the game engine in Typescript originally, but didn't like React Native that much and decided to port it to dart. To see progress more quickly, I postponed porting most of the tests.
- 1 player mode with bots with different strategies.
- Best of n mode (for 1 and 2 players).
- Automated pipelines for releasing application on different platforms.

## The Game

Originally, I discovered the game a while back on the _Cheapass Games_ website.
Now it is part of the _Chief Herman's Holiday Fun Pack_, which is available to buy and/or download on the [Crab Fragment Labs](https://crabfragmentlabs.com/shop/p/chief-herman-1) website

### Rules

**Flip** is a strategic change-making game using ten 6-sided dice.
To Begin: Each player rolls five 6-sided dice. The player who rolls the lowest total goes first. From here forward, the dice are never rolled again.

**On Each Turn:** You must do one of two things. You may either flip over one of your own dice, or you may instruct your opponent to play one of his dice into the middle of the table.

**Flipping:** The top and bottom numbers of 6-sided dice always sum to 7. If your dice are not set up like this, treat them as if they were. In other words, when you flip a 6 it must become a 1, whenyouflipa3itmustbecomea4,andsoon.
The object of flipping a die is usually to make it show a bigger number, though there are some strategic reasons to flip large dice down.

**Playing:** Choose one of your opponent’s dice. Your opponent must put that die into the middle of the table. He may then withdraw any combination of dice from the middle which totals less than the value of the die he put in. So, for example, if he plays a 5 into the middle, he could take up to 4 points worth of dice in any combination.
The object of instructing your opponent to play a die is to run him out of dice. However, you should probably not do this if he will take back more dice than he plays.

**Forbidden Moves:** To avoid stalemate, it is illegal to flip the same die twice without first making your opponent play a die.

**Winning:** To win the game, you must be the last player with any dice left. To keep score over several games, record the total pips showing on the dice you keep, and play to 50 points.
