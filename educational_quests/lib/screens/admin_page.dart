
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common_constants.dart';
import '../models/scores_model.dart';
import '../models/theme_provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  final readScores = FirebaseFirestore.instance.collection('scores').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Scores.fromJson(doc.data())).toList());

  bool _switchOn = false;

  @override
  Widget build(BuildContext context) {

    _switchOn = context.read<ThemeProvider>().theme == "dark";

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('БАЛЛЫ СТУДЕНТОВ', style: Theme.of(context).textTheme.headline1)),
        body: Container(
          decoration: _switchOn ? pageDecorationDark : pageDecorationLight,
          child: Center(
            child: StreamBuilder(
              stream: readScores,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final scoresList = snapshot.data!;
                  final textList = scoresList.map((scores) =>
                      Column(
                        children: [
                          ExpansionTile(
                              title: Text(scores.email, style: Theme.of(context).textTheme.bodyText1),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              expandedAlignment: Alignment.centerLeft,
                              childrenPadding: const EdgeInsets.only(left: 14),
                              backgroundColor: _switchOn ? const Color(0x34424DFF) : const Color(0xFFFFF5B0),
                              collapsedBackgroundColor: _switchOn ? const Color(0x34737BA4) : const Color(0xFFFBFFCD),
                              controlAffinity: ListTileControlAffinity.leading,
                              children: [
                                Text('\'Загадки Петербурга\':\n ${scores.riddlesScore}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                const SizedBox(height: 20),
                                Text('\'Петербургские парки\':\n ${scores.parksScore}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                const SizedBox(height: 20),
                                Text('\'Родной колледж\':\n ${scores.collegeScore}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                const SizedBox(height: 20),
                              ]
                          ),
                          const SizedBox(height: 10)
                        ],
                      )).toList();

                  return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    children: textList,
                  );

                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
