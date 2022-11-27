import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:page_transition/page_transition.dart';
import '../../common_constants.dart';
import '../../models/question.dart';
import '../quest_screens/quiz_screen.dart';

class MapRiddlesSpas extends StatefulWidget {
  const MapRiddlesSpas({Key? key}) : super(key: key);

  @override
  State<MapRiddlesSpas> createState() => _MapRiddlesSpasState();
}

class _MapRiddlesSpasState extends State<MapRiddlesSpas> {
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
                child: Text('Подойдите как можно ближе к месту, указанному на карте и нажмите кнопку "Я на месте". \n\nВам необходимо подойти к Храму Спаса на Крови.',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height / 2,
                color: Colors.white,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(59.939849, 30.328813),
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
                          point: LatLng(59.939849, 30.328813),
                          builder: (ctx) => Image.asset('assets/images/location_icon_1.png'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {

                  Navigator.of(context).pushReplacement(
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 900),
                          child: QuizScreen(
                              questions: Question.questionsSpas,
                              quizName: 'riddlesSpas',
                              routeName: '/map_riddles_horseman')
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