import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:playstation/ViewModel/gameDetailsViewModel.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:carousel_slider/carousel_slider.dart';

String geners = '';
String rating = '';
int id = 0;

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

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

    log("_GameDetails: ${data.imgUrl.length}");
    
    if (data.imgUrl.length > 0) {
      imgList.clear();
      for (var i in data.imgUrl) {
        imgList.add(i);
      }
    }
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
            SizedBox(
              child: CarouselSlider(
                options: CarouselOptions(),
                items: imgList.map(
                  (item) => Center(
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 1000
                    )
                  )
                ).toList(), 
              )
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> imageSliders = imgList
    .map((item) => Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'No. ${imgList.indexOf(item)} image',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    ))
    .toList();
}