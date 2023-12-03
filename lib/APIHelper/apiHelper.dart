import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// class ApiHelper {
//   //https://api.rawg.io/api/games/437049?key=02ef6ba5d13444ee86bad607e8bce3f4
//   var baseUrl = 'https://api.rawg.io/api/games/';
//   var endpointUrl = '';
//   var requestUrl = '';

//   ApiHelper(int gameID) {
//     endpointUrl = '$baseUrl$gameID';

//     Map<String, String> queryParams = {
//       'key': '02ef6ba5d13444ee86bad607e8bce3f4'
//     };
//     String queryString = Uri(queryParameters: queryParams).query;
//     requestUrl = '$endpointUrl?$queryString'; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2

//     // Uri url = Uri.parse(requestUrl);

//     // print('api url: '+requestUrl);

//     // var response = http.get(url);

//     // The Rest of code 
//   }
// }
 
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {

  String baseUrl = 'https://api.rawg.io/api/games/';
  String endpointUrl = '';
  String requestUrl = '';
  String queryString = '';

  Map<String, String> queryParams = {
    'key': '02ef6ba5d13444ee86bad607e8bce3f4'
  };

  void makeUrl() {
    queryString = Uri(queryParameters: queryParams).query;
    requestUrl = '$endpointUrl?$queryString';
  }

//Applying get request.
  Future<String> getRequest(String gameID) async {
    //replace your restFull API here.
    String baseUrl = 'https://api.rawg.io/api/games/';
    String endpointUrl = '';
    String requestUrl = '';
    String queryString = '';

    Map<String, String> queryParams = {
      'key': '02ef6ba5d13444ee86bad607e8bce3f4'
    };

    queryString = Uri(queryParameters: queryParams).query;
    requestUrl = '$endpointUrl?$queryString';

    final response = await http.get(Uri.parse(requestUrl));
 
    var responseData = json.decode(response.body);
 
    //Creating a list to store input data;
    
    return responseData.toString();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
