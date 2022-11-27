
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final FocusNode _emailFocusNode;
  late final FocusNode _loginFocusNode;
  late final FocusNode _passwordFocusNode;
  late TextEditingController _textFieldController;
  bool _isInputTextObscure = true;
  int count = 0;
  bool isChecked = false;

  final _txtStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18
  );

  final _fieldTxtStyle = const TextStyle(
      color: Colors.blueAccent,
      fontSize: 20
  );

  final _btnTxtStyle = const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600
  );

  final _counterTxtStyle = const TextStyle(
      color: Colors.lightBlueAccent
  );

  String _email = '';
  String _password = '';

  String _errorAlertMessage = '';

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
    _emailFocusNode = FocusNode();
    _loginFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _loginFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('РЕГИСТРАЦИЯ')),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2a0963),
                  Color(0xFF002f7a),
                  Color(0xFF004783),
                  Color(0xFF005b83),
                  Color(0xFF006d7e),
                  Color(0xFF437d7d),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Center(
            child: Scrollbar(
              thumbVisibility: true,
              radius: const Radius.circular(20),
              thickness: 8,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        focusNode: _emailFocusNode,
                        controller: _textFieldController,
                        maxLength: 30,
                        onChanged: (text) {
                          setState(() {
                            _email = text.trim();
                          });
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_passwordFocusNode);
                        },
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.purple,
                        cursorWidth: 1.8,
                        textAlign: TextAlign.center,
                        style: _fieldTxtStyle,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _textFieldController.clear();
                                setState(() {
                                  _email = '';
                                });
                              },
                              icon: const Icon(Icons.clear),
                            ),
                            hintText: 'Почта: ',
                            hintStyle:
                            TextStyle(fontSize: 16, color: Colors.grey[500]),
                            filled: true,
                            fillColor: Colors.white,
                            counterStyle: _counterTxtStyle,
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.purple[300]!, width: 4)),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2))),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        obscureText: _isInputTextObscure,
                        focusNode: _passwordFocusNode,
                        maxLength: 100,
                        onChanged: (text) {
                          setState(() {
                            _password = text;
                          });
                        },
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Colors.purple,
                        cursorWidth: 1.8,
                        textAlign: TextAlign.center,
                        style: _fieldTxtStyle,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                              icon: Icon(_isInputTextObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isInputTextObscure = !_isInputTextObscure;
                                });
                              },
                            ),
                            hintText: 'Пароль: ',
                            hintStyle:
                            TextStyle(fontSize: 16, color: Colors.grey[500]),
                            filled: true,
                            fillColor: Colors.white,
                            counterStyle: _counterTxtStyle,
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.purple[300]!, width: 4)),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                              checkColor: Colors.blue[700],
                              activeColor: Colors.white,
                              side: const BorderSide(
                                  color: Colors.white,
                                  width: 3
                              ),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              }),
                        ),
                        const Text('Я соглашаюсь с обработкой \nмоих персональных данных', style: TextStyle(
                            color: Colors.white, fontSize: 18
                        ), textAlign: TextAlign.center)
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                        onPressed: () async {

                          if (isChecked) {
                            if (fieldsAreNotEmpty([_email, _password])) {

                              if (!emailIsOk(_email) ||
                                  !passwordIsOk(_password)) {


                                if (!emailIsOk(_email)) {
                                  setState(() {
                                    _errorAlertMessage +=
                                    'Ошибка почты. Формат адреса почты должен быть по типу "example@email.com"\n\n';
                                  });
                                }


                                if (!passwordIsOk(_password)) {
                                  setState(() {
                                    _errorAlertMessage +=
                                    'Ошибка пароля. Пароль должен содержать хотя бы 1 цифру, 1 специальный символ, латинские буквы верхнего и нижнего регистра. Длина пароля не менее 6 символов.';
                                  });
                                }

                                // сообщение об ошибке регистрации
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      content: SingleChildScrollView(
                                        child: Text(
                                            (_errorAlertMessage.isEmpty || _errorAlertMessage == '') ? 'Неизвестная ошибка регистрации' : _errorAlertMessage,
                                            style: const TextStyle(
                                                color: Color(0xFF256D85),
                                                fontSize: 20),
                                            textAlign: TextAlign.left),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50)),
                                      backgroundColor: const Color(0xFFDFF6FF),
                                      actionsAlignment:
                                      MainAxisAlignment.center,
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Ок',
                                              style: TextStyle(
                                                  color: Color(0xFF47B5FF),
                                                  fontSize: 22)),
                                        ),
                                      ],
                                    ));

                                // аннулировать сообщение об ошибке
                                setState(() {
                                  _errorAlertMessage = '';
                                });


                              } else {

                                // записать на память устройства индикатор нового пользователя
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setBool("isUserNew", true);


                                // создание удалённой таблицы базы данных для пользователя
                                final collectionScore = FirebaseFirestore.instance.collection('scores');
                                collectionScore.doc(_email.trim()).set({
                                  'collegescore' : 0,
                                  'email' : _email.trim(),
                                  'parksscore' : 0,
                                  'riddlesscore' : 0
                                })
                                    .then((value) => print('COLLECTION SUCCESS!'))
                                    .catchError((error) => print(error));


                                // отправка данных по регистрации на сервер Firebase
                                try {
                                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: _email.trim(),
                                      password: _password.trim());
                                } on FirebaseAuthException catch (e) {
                                  print(e);
                                }


                                // сообщение об успешной регистрации
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text(
                                          'Поздравляем! Вы успешно зарегистрировались',
                                          style: TextStyle(
                                              color: Color(0xFF256D85),
                                              fontSize: 20),
                                          textAlign: TextAlign.center),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50)),
                                      backgroundColor: const Color(0xFFDFF6FF),
                                      actionsAlignment:
                                      MainAxisAlignment.center,
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.popUntil(context, (route) => count++ == 2);
                                          },
                                          child: const Text('Ок',
                                              style: TextStyle(
                                                  color: Color(0xFF47B5FF),
                                                  fontSize: 22)),
                                        ),
                                      ],
                                    ));





                              }
                            } else {

                              // сообщение о необходимости заполнить все поля
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text(
                                        'Все поля должны быть заполнены',
                                        style: TextStyle(
                                            color: Color(0xFF256D85),
                                            fontSize: 20),
                                        textAlign: TextAlign.center),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50)),
                                    backgroundColor: const Color(0xFFDFF6FF),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Ок',
                                            style: TextStyle(
                                                color: Color(0xFF47B5FF),
                                                fontSize: 22)),
                                      ),
                                    ],
                                  ));

                            }

                          } else {

                            // сообщение о необходимости согласия на обработку данных
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      'Без вашего согласия на обработку данных мы не можем вас зарегистрировать. Поставьте галочку для подтверждения своего согласия',
                                      style: TextStyle(
                                          color: Color(0xFF256D85),
                                          fontSize: 18),
                                      textAlign: TextAlign.center),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  backgroundColor: const Color(0xFFDFF6FF),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Ок',
                                          style: TextStyle(
                                              color: Color(0xFF47B5FF),
                                              fontSize: 22)),
                                    ),
                                  ],
                                ));


                          }



                        },
                        color: const Color(0xFF37DAE7),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.teal)
                        ),
                        child: Text('ЗАРЕГИСТРИРОВАТЬСЯ', style: _btnTxtStyle),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0, left: 40),
                      child: Text('Уже зарегистрированы?', style: _txtStyle, textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: const Color(0xFF37DAE7),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.teal)
                        ),
                        child: Text('ВХОД В ПРИЛОЖЕНИЕ', style: _btnTxtStyle, textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



  bool fieldsAreNotEmpty(List<String> fields) {
    for (String element in fields) {
      if (element.isEmpty || element == '') return false;
    }
    return true;
  }


  bool emailIsOk(String email) {
    return EmailValidator.validate(email);
  }


  bool passwordIsOk(String password) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~^%]).{6,}$');
    if (regex.hasMatch(password)) {
      return true;
    }

    return false;
  }



}

