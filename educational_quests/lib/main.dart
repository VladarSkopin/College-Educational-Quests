// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'peters_riddles_theme.dart';
import 'screens/main_page.dart';
import 'screens/map_screens/map_college.dart';
import 'screens/map_screens/map_parks_mars.dart';
import 'screens/map_screens/map_parks_michael.dart';
import 'screens/map_screens/map_parks_summer.dart';
import 'screens/map_screens/map_riddles_horseman.dart';
import 'screens/map_screens/map_riddles_kunst.dart';
import 'screens/map_screens/map_riddles_spas.dart';
import 'screens/map_screens/map_riddles_zinger.dart';
import 'screens/quest_screens/total_score_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider())
      ],
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: PetersRiddlesTheme.petersRiddlesLightTheme(),
      darkTheme: PetersRiddlesTheme.petersRiddlesDarkTheme(),
      themeMode: context.watch<ThemeProvider>().getTheme(),
      initialRoute: '/',
      routes: {
        '/' : (context) {
          return FutureBuilder(
              future: _syncTheme(context),
              builder: (context, snapshot) => MainPage());
        },
        '/total_score' : (context) => const TotalScoreScreen(),
        '/map_college' : (context) => const MapCollege(),
        '/map_parks_mars' : (context) => const MapParksMars(),
        '/map_parks_michael' : (context) => const MapParksMichael(),
        '/map_parks_summer' : (context) => const MapParksSummer(),
        '/map_riddles_horseman' : (context) => const MapRiddlesHorseman(),
        '/map_riddles_kunst' : (context) => const MapRiddlesKunst(),
        '/map_riddles_spas' : (context) => const MapRiddlesSpas(),
        '/map_riddles_zinger' : (context) => const MapRiddlesZinger()
      },
    );
  }

  Future<void> _syncTheme(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    context.read<ThemeProvider>().theme = _prefs.getString("theme") ?? "light";
  }
}

