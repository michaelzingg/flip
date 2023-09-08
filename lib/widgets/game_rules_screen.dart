import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class GameRules extends StatelessWidget {
  const GameRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('assets/text/rules.md'),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Markdown(data: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
