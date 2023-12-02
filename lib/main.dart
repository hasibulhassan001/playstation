import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_list_view/group_list_view.dart';
import 'dart:developer';


void main() => runApp(MyApp());

List<String> platforms = [];

Map<String, List> games = {};

Map<String, List> _elements = {
  'Team A': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
  'Team B': ['Toyah Downs', 'Tyla Kane'],
  'Team C': ['Marcus Romero', 'Farrah Parkes', 'Fay Lawson', 'Asif Mckay'],
  'Team D': ['Casey Zuniga', 'Ayisha Burn', 'Josie Hayden', 'Kenan Walls', 'Mario Powers'],
  'Team Q': ['Toyah Downs', 'Tyla Kane', 'Toyah Downs'],
  'Team X': ['Toyah Downs', 'Kenan Walls', 'Mario Powers'],
  'Team Z': ['Toyah Downs', 'Tyla Kane', 'Kenan Walls', 'Mario Powers'],
};

void _makeGameList() {
  List name = ['Klay Lewis', 'Ehsan Woodard', 'River Bains'];

  games = {for (var item in platforms) '$item' : name};

  log("GameList = ${games.toString()}");
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  List _items = [];
  String _name = "";

  // Fetch content from the json file
  Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/getgamelist.json');
  final data = await json.decode(response);
   _items = data["results"];

   _name = data["count"].toString();

   _gameList(_items);
   _logUser("Name = ${_name.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    
    _logUser("Main App Called");
    readJson();

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
          sectionsCount: _elements.keys.toList().length,
          countOfItemInSection: (int section) {
            return _elements.values.toList()[section].length;
          },
          itemBuilder: _itemBuilder,
          groupHeaderBuilder: (BuildContext context, int section) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(
                _elements.keys.toList()[section],
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
    String user = _elements.values.toList()[index.section][index.index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 8,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
          leading: CircleAvatar(
            child: Text(
              _getInitials(user),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          title: Text(
            _elements.values.toList()[index.section][index.index],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            _makeGameList();
          },
        ),
      ),
    );
  }

  String _getInitials(String user) {
    var buffer = StringBuffer();
    var split = user.split(" ");
    for (var s in split) {
      buffer.write(s[0]);
    }

    return buffer.toString().substring(0, split.length);
  }

  void _gameList(List game) {
    var i = 0, j = 0;

    log("GameList Size = ${game.length}");
    log("platform = ${game[0]["platforms"][0]["platform"]["name"].toString()}");

    for (i = 0;  i < game.length; i++) {
      for (j = 0; j < game[i]["platforms"].length; j++) {
        platforms.add(game[i]["platforms"][j]["platform"]["name"]);
      }
      j = 0;
    }
    platforms = platforms.toSet().toList();
    log(platforms.toString());
  }

  void _logUser(String user) {
    log(user);
  }
}