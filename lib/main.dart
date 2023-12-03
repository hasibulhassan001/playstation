import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_list_view/group_list_view.dart';
import 'dart:developer';
import 'package:playstation/View/gamedetails.dart';
import 'ViewModel/gameDetailsViewModel.dart';
import 'APIHelper/apiHelper.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

List _items = [];
List<String> platforms = [];

List<String> platforms1 = [];
List<String> platforms2 = [];
List<String> platforms3 = [];
List<String> platforms4 = [];
List<String> platforms5 = [];
List<String> platforms6 = [];
List<String> platforms7 = [];

Map<String, List> mapGames = {};

void _makeGameList(List gameList) {
  var i = 0, j = 0;
  for (i = 0; i<gameList.length; i++) {
    for (j = 0; j < gameList[i]["platforms"].length; j++) {
      if (gameList[i]["platforms"][j]["platform"]["name"] == 'PC') {
        platforms1.add(gameList[i]["name"]);
      }

      if (gameList[i]["platforms"][j]["platform"]["name"] == 'PlayStation 5') {
        platforms2.add(gameList[i]["name"]);
      }

      if (gameList[i]["platforms"][j]["platform"]["name"] == 'Xbox One') {
        platforms3.add(gameList[i]["name"]);
      }

      if (gameList[i]["platforms"][j]["platform"]["name"] == 'PlayStation 4') {
        platforms4.add(gameList[i]["name"]);
      }

      if (gameList[i]["platforms"][j]["platform"]["name"] == 'Xbox Series S/X') {
        platforms5.add(gameList[i]["name"]);
      }

      if (gameList[i]["platforms"][j]["platform"]["name"] == 'Nintendo Switch') {
        platforms6.add(gameList[i]["name"]);
      }

      if (gameList[i]["platforms"][j]["platform"]["name"] == 'macOS') {
        platforms7.add(gameList[i]["name"]);
      }
    }
    j = 0;
  }

  log("PC games = ${platforms1.toSet().toList().toString()}");
  log("PC = ${platforms1.length}");
  log("PC = ${platforms2.length}");
  log("PC = ${platforms3.length}");
  log("PC = ${platforms4.length}");
  log("PC = ${platforms5.length}");
  log("PC = ${platforms6.length}");
  log("PC = ${platforms7.length}");

  _makeGameCollection('PC', platforms1);
  _makeGameCollection('PlayStation 5', platforms2);
  _makeGameCollection('Xbox One', platforms3);
  _makeGameCollection('PlayStation 4', platforms4);
  _makeGameCollection('Xbox Series S/X', platforms5);
  _makeGameCollection('Nintendo Switch', platforms6);
  _makeGameCollection('macOS', platforms7);
}

void _makeGameCollection(String item,List games) {

  mapGames.addEntries({item : games}.entries);
}

void clearAllList() {
  _items.clear();
  platforms.clear();
  platforms1.clear();
  platforms2.clear();
  platforms3.clear();
  platforms4.clear();
  platforms5.clear();
  platforms6.clear();
  platforms7.clear();
  mapGames.clear();

  log("_items : ${_items.length}");
  log("platforms : ${platforms.length}");
  log("platforms1 : ${platforms1.length}");
  log("platforms2 : ${platforms2.length}");
  log("platforms3 : ${platforms3.length}");
  log("platforms4 : ${platforms4.length}");
  log("platforms5 : ${platforms5.length}");
  log("platforms6 : ${platforms6.length}");
  log("platforms7 : ${platforms7.length}");
  log("mapGames : ${mapGames.length}");
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Fetch content from the json file
  // Future<void> readJson(String responseStr) async {
  //   // log("Json to Str: $responseStr");
  //   // final String response = await rootBundle.loadString(responseStr);
  //   // final data = await json.decode(response);
  //   _items = responseStr["results"];

  //   _gameList(_items);
  //   _makeGameList(_items);
  // }

  //Applying get request.
  Future<void> getGameList() async {
    //replace your restFull API here.
    String baseUrl = 'https://api.rawg.io/api/games';
    String endpointUrl = '';
    String requestUrl = '';
    String queryString = '';

    //https://api.rawg.io/api/games?page=1&page_size=20&platforms=187&dates=2020-12-21,2021-12-21&ordering=-released&key=02ef6ba5d13444ee86bad607e8bce3f4
    Map<String, String> queryParams = {
      'page': '1',
      'page_size': '20',
      'platforms': '187',
      'dates': '2020-12-21,2021-12-21',
      'ordering': '-released',
      'key': '02ef6ba5d13444ee86bad607e8bce3f4'
    };

    endpointUrl = baseUrl;//'$baseUrl$gameID';
    queryString = Uri(queryParameters: queryParams).query;
    requestUrl = '$endpointUrl?$queryString';

    log("API Url: $requestUrl");

    final response = await http.get(Uri.parse(requestUrl));
 
    var responseData = json.decode(response.body);
    _items = responseData["results"];
    _gameList(_items);
    _makeGameList(_items);
  }

  @override
  Widget build(BuildContext context) {
    _logUser("Main App Called");
    getGameList();

    return MaterialApp(
      title: 'PlayStation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PlayStation Demo'),
        ),
        body: GroupListView(
          sectionsCount: mapGames.keys.toList().length,
          countOfItemInSection: (int section) {
            return mapGames.values.toList()[section].length;
          },
          itemBuilder: _itemBuilder,
          groupHeaderBuilder: (BuildContext context, int section) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(
                mapGames.keys.toList()[section],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          sectionSeparatorBuilder: (context, section) => const SizedBox(height: 10),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, IndexPath index) {
    String user = mapGames.values.toList()[index.section][index.index];
    GameData data = _getGameData(user);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 8,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
          title: Text(
            mapGames.values.toList()[index.section][index.index],
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            "Released: ${data.releaseDate}\nMetacritic: ${data.metacritic}",
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            ),
          trailing: Image.network(
                data.imageLink,
                width: 80,
                height: 200,
                fit: BoxFit.fill,
              ),
          onTap: () {
            _awaitReturnValueFromSecondScreen(context, data);
          },
        ),
      ),
    );
  }

  String _getInitials(String user) {
    var buffer = StringBuffer();
    final result = user.split(' ').take(2).join(' ');
    var split = result.split(" ");
    for (var s in split) {
      buffer.write(s[0]);
    }

    log("Game Name =  ${buffer.toString().substring(0, split.length)}");
    return buffer.toString().substring(0, split.length);
  }

  void _gameList(List game) {
    var i = 0, j = 0;
    for (i = 0;  i < game.length; i++) {
      for (j = 0; j < game[i]["platforms"].length; j++) {
        platforms.add(game[i]["platforms"][j]["platform"]["name"]);
      }
      j = 0;
    }
    platforms = platforms.toSet().toList();
    log(platforms.toString());
  }

  GameData _getGameData(String gameName) {
    String imageLink = '';
    String releaseDate = '';
    int metacritic = -1;
    int gameID = 0;

    for (var i = 0;  i < _items.length; i++) {
      if (gameName == _items[i]["name"]) {
        gameID = _items[i]["id"];
        imageLink = _items[i]["background_image"];
        releaseDate = _items[i]["released"];
        if (_items[i]["metacritic"] != null) {
          metacritic = _items[i]["metacritic"];
        }
        else {
          metacritic = 0;
        }
      }
    }
    log("Url: $imageLink");
    return GameData(gameName, imageLink, releaseDate, metacritic, gameID);
  }

  void _logUser(String user) {
    log(user);
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context, GameData data) async {
    log("Data : ${data.gameName}");

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GameDetails(),
          settings: RouteSettings(
            arguments: data
          ),
        ),
      );
  }
}