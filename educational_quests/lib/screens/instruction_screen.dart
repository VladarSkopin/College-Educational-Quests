import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common_constants.dart';
import '../models/theme_provider.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  bool _switchOn = false;


  @override
  Widget build(BuildContext context) {
    _switchOn = context.read<ThemeProvider>().theme == "dark";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('ИНСТРУКЦИЯ', style: Theme.of(context).textTheme.headline1)),
        body: Container(
          decoration: _switchOn ? pageDecorationDark : pageDecorationLight,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 6),
                    child: Text('Добро пожаловать на страничку инструкций по обучающим квестам!',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                    child: Text('На данный момент имеется три квеста - "Загадки Петербурга", "Петербургские парки" и "Родной колледж".',
                        style: TextStyle(
                            fontSize: 16
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                    child: Text('Вне зависимости от выбранного вами квеста, порядок действий остаётся одинаковым:'
                        '\n\n1) После выбора квеста внимательно читайте, к какому месту вам нужно прийти:',
                        style: TextStyle(fontSize: 16)),
                  ),
                  Image.asset('assets/instructions/instructions_1.PNG', scale: 1.5),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                    child: Text(
                        'Квест рассчитан на визуальную составляющую, поэтому желательно присутствовать на обозначенной в квесте локации.',
                        style: TextStyle(fontSize: 16)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                    child: Text(
                        'Нажмите на кнопку "Я НА МЕСТЕ", чтобы приступить к ответам на вопросы по указанной на карте локации:',
                        style: TextStyle(fontSize: 16)),
                  ),
                  Image.asset('assets/instructions/instructions_2.PNG', scale: 1.5),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                    child: Text(
                        '2) На каждую локацию даётся по 5 вопросов с вариантами ответа. Чем больше правильных ответов вы выберете, тем больше наберёте баллов:',
                        style: TextStyle(fontSize: 16)),
                  ),
                  Image.asset('assets/instructions/instructions_3.PNG', scale: 1.5),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                    child: Text(
                        '3) После выполнения квеста вы увидете финальную страничку со всеми баллами по вопросам.', style: TextStyle(fontSize: 16)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                    child: Text('PS: Кстати, все ваши баллы по квестам вы можете посмотреть в своём профиле, для этого нажмите по кнопке слева вверху на главной странице "ОБУЧАЮЩИЕ КВЕСТЫ":', style: TextStyle(fontSize: 16)),
                  ),
                  Image.asset('assets/instructions/instructions_4.PNG', scale: 1.5),
                  const SizedBox(height: 20),
                  Image.asset('assets/instructions/instructions_5.PNG', scale: 1.5),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                    child: Text('Удачи в прохождении обучающих квестов!',
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: _switchOn ? boxDecorationAuthorCardDark : boxDecorationAuthorCardLight,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 6),
                      child: Text(
                          'Автор: \nСкопинцев Александр Александрович \n\nИСПО, гр.з428/1\n\n2022 г.',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
