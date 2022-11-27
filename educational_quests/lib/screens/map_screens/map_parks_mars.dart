import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:page_transition/page_transition.dart';
import '../../common_constants.dart';
import '../../models/question.dart';
import '../quest_screens/quiz_screen.dart';

class MapParksMars extends StatefulWidget {
  const MapParksMars({Key? key}) : super(key: key);

  @override
  State<MapParksMars> createState() => _MapParksMarsState();
}

class _MapParksMarsState extends State<MapParksMars> {
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
                child: Text('Подойдите как можно ближе к месту, указанному на карте и нажмите кнопку "Я на месте". \n\nВам необходимо подойти к Марсовому полю.',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height / 2,
                color: Colors.white,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(59.943563, 30.331856),
                    zoom: 15.0,
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
                          point: LatLng(59.943563, 30.331856),
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
                              questions: Question.questionsMarsField,
                              quizName: 'parksMars',
                              routeName: '/map_parks_summer')
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