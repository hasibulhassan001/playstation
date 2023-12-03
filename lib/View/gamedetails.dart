import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
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

void getGameData(var responseData) {
  geners = '';
  log("getGameData: ${responseData["genres"].length}");
  for (var i = 0; i < responseData["genres"].length; i++) {
    // ignore: prefer_interpolation_to_compose_strings
    geners = '$geners '+responseData["genres"][i]["name"];
  }
  rating = responseData["rating"].toString();
  log("OBJ: ${geners.toString()}");
}

class _GameDetails extends State<GameDetails> {
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    setState(() {
      getGameDetails(id);
    });
  }

  void getGameDetails(int gameID) async {
    //replace your restFull API here.
    String baseUrl = 'https://api.rawg.io/api/games/';
    String endpointUrl = '';
    String requestUrl = '';
    String queryString = '';

    //https://api.rawg.io/api/games/437049?key=02ef6ba5d13444ee86bad607e8bce3f4
    Map<String, String> queryParams = {
      'key': '02ef6ba5d13444ee86bad607e8bce3f4'
    };

    endpointUrl = '$baseUrl$gameID';
    queryString = Uri(queryParameters: queryParams).query;
    requestUrl = '$endpointUrl?$queryString';

    log("API Url: $requestUrl");

    final response = await http.get(Uri.parse(requestUrl));
 
    var responseData = json.decode(response.body);

    setState(() => isLoading = false);

    getGameData(responseData);
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