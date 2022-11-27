import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../common_constants.dart';
import '../map_screens/map_college.dart';

class QuestCollegeScreen extends StatelessWidget {
  const QuestCollegeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('РОДНОЙ КОЛЛЕДЖ'),),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/college.png'),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.6),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text('Внимание!',
                      style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
                  Text('\nПрежде чем начать квест, убедитесь, что вы находитесь в районе Удельного парка.\n\nИначе вам придётся очень долго добираться до первого места по квесту.',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 800),
                              child: const MapCollege()
                          )
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: const Text('Я ГОТОВ, НАЧИНАЕМ!', style: btnTextStyleDark, textAlign: TextAlign.center),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: const Text('НАЗАД, Я НЕ ГОТОВ', style: btnTextStyleDark, textAlign: TextAlign.center),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
