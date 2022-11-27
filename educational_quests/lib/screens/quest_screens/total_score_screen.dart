import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_constants.dart';

class TotalScoreScreen extends StatefulWidget {
  const TotalScoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TotalScoreScreen> createState() => _TotalScoreScreenState();
}

class _TotalScoreScreenState extends State<TotalScoreScreen> {

  int count = 0;
  int collegeScore = 0;
  int parksMarsScore = 0;
  int parksSummerScore = 0;
  int parksMichaelScore = 0;
  int zingerScore = 0;
  int spasScore = 0;
  int horsemanScore = 0;
  int kunstScore = 0;
  String lastQuiz = '';
  String scoresRendered = "Загружаются результаты...";
  int totalScoreParks = 0;
  int totalScoreRiddles = 0;


  @override
  void initState() {
    super.initState();
    loadLastQuiz();
  }

  Future<void> loadLastQuiz() async {
    final prefs = await SharedPreferences.getInstance();
    String lastQuizFromPrefs = prefs.getString('lastQuiz') ?? '';
    int collegeScoreFromPrefs = prefs.getInt('college') ?? 0;
    int parksMarsScoreFromPrefs = prefs.getInt('parksMars') ?? 0;
    int parksSummerScoreFromPrefs = prefs.getInt('parksSummer') ?? 0;
    int parksMichaelScoreFromPrefs = prefs.getInt('parksMichael') ?? 0;
    int zingerScoreFromPrefs = prefs.getInt('riddlesZinger') ?? 0;
    int spasScoreFromPrefs = prefs.getInt('riddlesSpas') ?? 0;
    int horsemanScoreFromPrefs = prefs.getInt('riddlesHorseman') ?? 0;
    int kunstScoreFromPrefs = prefs.getInt('riddlesKunst') ?? 0;

    setState(() {
      lastQuiz = lastQuizFromPrefs;
      if (lastQuiz == 'collegeWasLastQuiz') {
        collegeScore = collegeScoreFromPrefs;
      } else if (lastQuiz == 'parksWasLastQuiz') {
        parksMarsScore = parksMarsScoreFromPrefs;
        parksSummerScore = parksSummerScoreFromPrefs;
        parksMichaelScore = parksMichaelScoreFromPrefs;
      } else if (lastQuiz == 'riddlesWasLastQuiz') {
        zingerScore = zingerScoreFromPrefs;
        spasScore = spasScoreFromPrefs;
        horsemanScore = horsemanScoreFromPrefs;
        kunstScore = kunstScoreFromPrefs;
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;
    String currentUserEmail = user.email ?? "admin@ispo.com";

    if (lastQuiz == 'collegeWasLastQuiz') {
      scoresRendered = '';
      scoresRendered += 'Колледж: $collegeScore из 5';
      scoresRendered += '\n\nИтого: $collegeScore баллов';
    } else if (lastQuiz == 'parksWasLastQuiz') {
      scoresRendered = '';
      scoresRendered += 'Марсово поле: $parksMarsScore из 5';
      scoresRendered += '\n\nЛетний сад: $parksSummerScore из 5';
      scoresRendered += '\n\nМихайловский сад: $parksMichaelScore из 5';
      totalScoreParks = parksMarsScore + parksSummerScore + parksMichaelScore;
      scoresRendered += '\n\nИтого: $totalScoreParks баллов';
    } else if (lastQuiz == 'riddlesWasLastQuiz') {
      scoresRendered = '';
      scoresRendered += 'Зингер: $zingerScore из 5';
      scoresRendered += '\n\nХрам Спаса на Крови: $spasScore из 5';
      scoresRendered += '\n\nМедный всадник: $horsemanScore из 5';
      scoresRendered += '\n\nКунсткамера: $kunstScore из 5';
      totalScoreRiddles = zingerScore + spasScore + horsemanScore + kunstScore;
      scoresRendered += '\n\nИтого: $totalScoreRiddles баллов';
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg_2.png'),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/images/wreath_1.png')),
                  const SizedBox(height: 20),
                  const Text('ОБЩИЙ СЧЁТ ПО ТЕСТАМ:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 40),
                  Text(scoresRendered, style: const TextStyle(fontSize: 19, color: Colors.white), textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      int countUntil = prefs.getInt('popUntil') ?? 3;


                      if (lastQuiz == 'collegeWasLastQuiz') {
                        // Firebase -> получаем удалённую коллекцию (БД)
                        final docScore = FirebaseFirestore.instance.collection('scores').doc(currentUserEmail);

                        final json = {
                          'collegescore' : collegeScore,
                        };

                        // отправка данных на удалённый сервер Firebase
                        await docScore.update(json);

                      } else if (lastQuiz == 'parksWasLastQuiz') {
                        // Firebase -> получаем удалённую коллекцию (БД)
                        final docScore = FirebaseFirestore.instance.collection('scores').doc(currentUserEmail);

                        final json = {
                          'parksscore' : totalScoreParks,
                        };

                        // отправка данных на удалённый сервер Firebase
                        await docScore.update(json);

                      } else if (lastQuiz == 'riddlesWasLastQuiz') {
                        // Firebase -> получаем удалённую коллекцию (БД)
                        final docScore = FirebaseFirestore.instance.collection('scores').doc(currentUserEmail);

                        final json = {
                          'riddlesscore' : totalScoreRiddles,
                        };

                        // отправка данных на удалённый сервер Firebase
                        await docScore.update(json);

                      }


                      Navigator.of(context).popUntil((route) => count++ == countUntil);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: boxDecorationBtn,
                      child: const Text('ЗАВЕРШИТЬ КВЕСТ', style: btnTextStyleDark, textAlign: TextAlign.center),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
