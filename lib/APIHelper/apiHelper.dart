import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int callingID = 0;

class ApiHelper {
  //https://api.rawg.io/api/games/437049?key=02ef6ba5d13444ee86bad607e8bce3f4
  var baseUrl = 'https://api.rawg.io/api/games/';
  var endpointUrl = '';
  var requestUrl = '';

  ApiHelper(int id) {
    callingID = id;
    HomePage();
  }
}
 
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {

  List gameList = [];

  //Applying get request.
  Future<List> getGameList() async {
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

    final response = await http.get(Uri.parse(requestUrl));
 
    var responseData = json.decode(response.body);
    gameList = responseData["results"];
    return gameList;
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getGameList();
    throw UnimplementedError();
  }
}
