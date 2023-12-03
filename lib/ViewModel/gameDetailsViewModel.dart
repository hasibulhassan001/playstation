import 'package:flutter/material.dart';

class GameData {
  String gameName = '';
  String imageLink = '';
  String releaseDate = '';
  int metacritic = -1;
  int gameID = 0;

  GameData(this.gameName,this.imageLink,this.releaseDate,this.metacritic,this.gameID);
}

class GameInfo {
  List geners = [];

  GameInfo(this.geners);
}