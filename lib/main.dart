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
    final x = Theme.of(context);
    return Scaffold(
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(children: [
        Container(
          margin: const EdgeInsets.all(100),
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
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
            label: const Text('2 Players'),
            icon: const Icon(Icons.group),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        GameScreen(state: create(seed: 77))))),
        Container(
          margin: const EdgeInsets.all(100),
          child: TextButton.icon(
            label: Text(
              'Rules',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onPressed: () {},
            icon: const Icon(Icons.book),
          ),
        )
      ])),
    );
  }
}
