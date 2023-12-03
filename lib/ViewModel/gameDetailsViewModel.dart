import 'package:flutter/material.dart';

class GameData {
  String gameName = '';
  String imageLink = '';
  String releaseDate = '';
  int metacritic = -1;
  int gameID = 0;
  String geners = '';
  String rating = '';

  GameData(this.gameName,this.imageLink,this.releaseDate,this.metacritic,this.gameID, this.geners, this.rating);
}

class GameInfo {
  List geners = [];

  GameInfo(this.geners);
}