import 'package:flutter/material.dart';

class GameData {
  String gameName = '';
  String imageLink = '';
  String releaseDate = '';
  int metacritic = -1;
  int gameID = 0;
  String geners = '';
  String rating = '';
  List imgUrl = [];

  GameData(this.gameName,this.imageLink,this.releaseDate,this.metacritic,this.gameID, this.geners, this.rating, this.imgUrl);
}

class GameInfo {
  List geners = [];

  GameInfo(this.geners);
}