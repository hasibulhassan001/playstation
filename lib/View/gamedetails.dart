import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playstation/ViewModel/gameDetailsViewModel.dart';

class GameDetails extends StatefulWidget {
  const GameDetails({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameDetails createState() {
    return _GameDetails();
  }
}

class _GameDetails extends State<GameDetails> {
  // this allows us to access the TextField text
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as GameData;
    log("_GameDetails: ${data.gameName}");
    return Scaffold(
      appBar: AppBar(title: const Text('Game Details')),
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              child: Image.network(
                "https://images.unsplash.com/photo-1547721064-da6cfb341d50?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                width: double.infinity,
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              child: Text(data.gameName),
            ),
          ],
        ),
      ),
    );
  }

  // get the text in the TextField and send it back to the FirstScreen
  void _sendDataBack(BuildContext context) {
    String textToSendBack = textFieldController.text;
    Navigator.pop(context, textToSendBack);
  }
}