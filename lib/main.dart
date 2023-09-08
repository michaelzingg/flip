import 'package:flip/game/engine/actions/create.dart';
import 'package:flip/widgets/game_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'FL!P',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 120),
          child: Column(
            children: [
              Text('FL!P',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 70)),
              Text('A dice game for two',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
            ],
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
            icon: const Icon(Icons.group),
            label: const Text('2 Players'),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 50),
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        GameScreen(state: create(seed: 77))))),
        const Spacer(),
        Container(
          margin: const EdgeInsets.all(50),
          child: TextButton.icon(
            icon: const Icon(Icons.book),
            label: Text(
              'Rules',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            style: TextButton.styleFrom(
              fixedSize: const Size(200, 50),
            ),
            onPressed: () {},
          ),
        )
      ])),
    );
  }
}
