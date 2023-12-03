import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:playstation/ViewModel/gameDetailsViewModel.dart';

String geners = '';
String rating = '';
int id = 0;

class GameDetails extends StatefulWidget {
  const GameDetails({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameDetails createState() {
    return _GameDetails();
  }
}

class _GameDetails extends State<GameDetails> {
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    setState(() {
      // getGameDetails(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as GameData;
    id = data.gameID;
    log("_GameDetails: ${data.gameName}");
    return Scaffold(
      appBar: AppBar(title: const Text('Game Details')),
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              child: Image.network(
                data.imageLink,
                width: double.infinity,
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              child: Text(
                "Game Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
            ),
            SizedBox(
              child: Text("Name: ${data.gameName}"),
            ),
            SizedBox(
              child: Text("Release Date: ${data.releaseDate}"),
            ),
            SizedBox(
              child: Text("Genres: $geners"),
            ),
            SizedBox(
              child: Text("Rating: $rating"),
            ),
          ],
        ),
      ),
    );
  }
}