import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_constants.dart';
import '../../models/question.dart';
import '../quest_screens/quiz_screen.dart';

class MapRiddlesKunst extends StatefulWidget {
  const MapRiddlesKunst({Key? key}) : super(key: key);

  @override
  State<MapRiddlesKunst> createState() => _MapRiddlesKunstState();
}

class _MapRiddlesKunstState extends State<MapRiddlesKunst> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: boxDecorationDefault,
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                child: Text('Подойдите как можно ближе к месту, указанному на карте и нажмите кнопку "Я на месте". \n\nВам необходимо подойти к зданию Кунсткамеры.',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height / 2,
                color: Colors.white,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(59.941355, 30.304581),
                    zoom: 16.0,
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate: "https://api.mapbox.com/styles/v1/alexus7skopinus/cla9lll09000w14q8nt6wxtpa/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYWxleHVzN3Nrb3BpbnVzIiwiYSI6ImNsYTlrOHBmYzA5cTIzb3Q1Y3J2Y2NoOGMifQ.siZVtEHZq573xBrx9bHzSA",
                        //subdomains: ['a', 'b', 'c']
                        additionalOptions: {
                          'accessToken' : 'pk.eyJ1IjoiYWxleHVzN3Nrb3BpbnVzIiwiYSI6ImNsYTlrOHBmYzA5cTIzb3Q1Y3J2Y2NoOGMifQ.siZVtEHZq573xBrx9bHzSA',
                          'id' : 'mapbox.mapbox-streets-v8'
                        }
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(59.941355, 30.304581),
                          builder: (ctx) => Image.asset('assets/images/location_icon_1.png'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () async {

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('popUntil', 6);
                  await prefs.setString('lastQuiz', 'riddlesWasLastQuiz');

                  Navigator.of(context).pushReplacement(
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 900),
                          child: QuizScreen(
                              questions: Question.questionsKunst,
                              quizName: 'riddlesKunst',
                              routeName: '/total_score')
                      )
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: boxDecorationBtn,
                  child: const Text('Я НА МЕСТЕ', style: btnTextStyleDark, textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}