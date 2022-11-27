
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_constants.dart';
import '../models/scores_model.dart';
import '../models/theme_provider.dart';
import 'admin_page.dart';
import 'instruction_screen.dart';
import 'quest_choice_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;
  final readScores = FirebaseFirestore.instance.collection('scores').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Scores.fromJson(doc.data())).toList());


  bool _switchOn = false;

  @override
  void initState() {
    loadIsUserNew();
    super.initState();
  }

  // проверить индикатор - является ли текущий пользователь новым
  Future loadIsUserNew() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("isUserNew") ?? false) {
      FirebaseAuth.instance.signOut();
    }
    await prefs.setBool("isUserNew", false);
  }


  @override
  Widget build(BuildContext context) {


    ThemeProvider appWatcher = context.watch<ThemeProvider>();
    _switchOn = context.read<ThemeProvider>().theme == "dark";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('ОБУЧАЮЩИЕ КВЕСТЫ', style: Theme.of(context).textTheme.headline1)),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width / 1.5,
          elevation: 8.0,
          child: ListView(
            children: <Widget>[
              ListTile(
                tileColor: _switchOn ? const Color(0xFF222D49) : const Color(0xFFADE3D0),
                title: MaterialButton(
                  onPressed: () {

                    showDialog(
                        context: context,
                        builder: (BuildContext context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: AlertDialog(
                            title: const Text(
                                'Вы уверены, что хотите выйти?',
                                style: TextStyle(
                                    color: Color(0xFF256D85)),
                                textAlign: TextAlign.left),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor: const Color(0xFFDFF6FF),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  FirebaseAuth.instance.signOut();
                                },
                                child: const Text('Да',
                                    style: TextStyle(
                                        color: Color(0xFF47B5FF), fontSize: 22)),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Нет',
                                    style: TextStyle(
                                        color: Color(0xFF47B5FF), fontSize: 22)),
                              ),
                            ],
                          ),
                        ));


                  },
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 25, color: _switchOn ? Colors.white : Colors.black),
                      const SizedBox(width: 20),
                      Text('выйти', style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
              ),
              UserAccountsDrawerHeader(
                decoration: _switchOn ? darkDecorationProfile : lightDecorationProfile,
                currentAccountPicture: Icon(Icons.person, size: 50, color: _switchOn ? const Color(0xFFFFFFCC) : Colors.white),
                accountName: Text(user.displayName ?? '', style: Theme.of(context).textTheme.bodyText1),
                accountEmail: Text(user.email ?? '', style: Theme.of(context).textTheme.bodyText1),
              ),
              ListTile(
                title: Text(
                    _switchOn ? 'Тёмная тема' : 'Светлая тема',
                    style: Theme.of(context).textTheme.bodyText1),
                trailing: Switch(
                  inactiveThumbColor: const Color(0xFF31C6D4),
                  inactiveTrackColor: const Color(0xFFE2E200),
                  activeColor: const Color(0xFF8300E8),
                  value: _switchOn,
                  onChanged: (value) async {
                    setState(() {
                      _switchOn = value;
                    });
                    if (_switchOn) {
                      appWatcher.theme == "dark";
                      await _setTheme(1, context);
                    } else {
                      appWatcher.theme == "light";
                      await _setTheme(0, context);
                    }
                  },
                ),
              ),
              const Divider(
                color: Colors.blueGrey,
                height: 4,
                thickness: 2,
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream: readScores,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    final scoresList = snapshot.data!;
                    Scores? currentScore;
                    for (int i = 0; i < scoresList.length; i++) {
                      if (scoresList[i].email == user.email) {
                        currentScore = scoresList[i];
                      }
                    }
                    int riddlesScores = currentScore?.riddlesScore ?? 0;
                    int parksScores = currentScore?.parksScore ?? 0;
                    int collegeScores = currentScore?.collegeScore ?? 0;

                    return ExpansionTile(
                      title: Text('Ваш общий счёт по квестам:', style: Theme.of(context).textTheme.bodyText1),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.centerLeft,
                      childrenPadding: const EdgeInsets.only(left: 14),
                      backgroundColor: _switchOn ? const Color(0x34424DFF) : const Color(0xFFFFF5B0),
                      collapsedBackgroundColor: _switchOn ? const Color(0x341C2162) : const Color(0x346DEEEE),
                      iconColor: _switchOn ? Colors.purpleAccent : Colors.teal,
                      collapsedIconColor: _switchOn ? Colors.purple : Colors.green,
                      children: [
                        const SizedBox(height: 20),
                        Text('\'Загадки Петербурга\':\n $riddlesScores / 20', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 20),
                        Text('\'Петербургские парки\':\n $parksScores / 15', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 20),
                        Text('\'Родной колледж\':\n $collegeScores / 5', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 20),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
        body: Container(
          decoration: _switchOn ? pageDecorationDark : pageDecorationLight,
          child: Center(
              child:
              SingleChildScrollView(
                child: Column(
                  children: [

                    // если текущий пользователь - администратор (email = "admin@ispo.com")
                    user.email == 'admin@ispo.com' ?
                    const SizedBox(height: 16) : const SizedBox(height: 1),
                    user.email == 'admin@ispo.com' ?
                    Image.asset('assets/images/tools.png', scale: 12) : const SizedBox(height: 1),
                    user.email == 'admin@ispo.com' ?
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 900),
                                    child: const AdminPage()
                                )
                            );
                          },
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Color(0xFF7ED5FF))
                          ),
                          child: Text('Просмотр данных\n всех студентов', style: Theme.of(context).textTheme.headline1)
                      ),
                    ) : const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    Image.asset('assets/images/scroll.png', scale: 7),
                    MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 900),
                                  child: const InstructionScreen()
                              )
                          );
                        },
                        color: _switchOn ? Colors.black : const Color(0xFF31C6D4),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Color(0xFF7ED5FF))
                        ),
                        child: Text('Инструкция', style: Theme.of(context).textTheme.headline1)
                    ),
                    const SizedBox(height: 50),
                    Image.asset('assets/images/logo_4.png', scale: 7),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            PageTransition(
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 900),
                                child: const QuestChoiceScreen()
                            )
                        );
                      },
                      color: _switchOn ? Colors.black : const Color(0xFF31C6D4),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Color(0xFF7ED5FF))
                      ),
                      child: Text('Начать', style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 28)),
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  Future<void> _setTheme(int index, BuildContext context) async {
    String _theme = index == 0 ? "light" : "dark";
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("theme", _theme);
    context.read<ThemeProvider>().theme = _theme;
  }

}
