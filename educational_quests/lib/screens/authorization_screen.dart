
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'registration_screen.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  late final FocusNode _passwordFocusNode;
  late TextEditingController _textFieldController_1;
  bool _isInputTextObscure = true;

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

  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _textFieldController_1 = TextEditingController();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('ДОБРО ПОЖАЛОВАТЬ!'),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6a007a),
                  Color(0xFF48409c),
                  Color(0xFF1160ae),
                  Color(0xFF007ab1),
                  Color(0xFF3990ad),
                  Color(0xFF6da3ab),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.person, color: Colors.white, size: 60),
                  const SizedBox(height: 10),
                  Text('Введите ваш email и пароль: ', style: _txtStyle, textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      controller: _textFieldController_1,
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
                          prefixIcon: const Icon(Icons.login),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _textFieldController_1.clear();
                              setState(() {
                                _email = '';
                              });
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          hintText: 'Email: ',
                          hintStyle: TextStyle(
                              fontSize: 18, color: Colors.grey[500]
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.purple[300]!, width: 4)),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2))
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      obscureText: _isInputTextObscure,
                      focusNode: _passwordFocusNode,
                      onChanged: (text) {
                        setState(() {
                          _password = text.trim();
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
                            icon: Icon(
                                _isInputTextObscure ? Icons.visibility : Icons.visibility_off
                            ),
                            onPressed: () {
                              setState(() {
                                _isInputTextObscure = !_isInputTextObscure;
                              });
                            },
                          ),
                          hintText: 'Пароль: ',
                          hintStyle: TextStyle(
                              fontSize: 18, color: Colors.grey[500]
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.purple[300]!, width: 4)),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2))
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                      onPressed: signIn,
                      color: const Color(0xFF37DAE7),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.teal)
                      ),
                      child: Text('ВОЙТИ', style: _btnTxtStyle),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text('Ещё не зарегистрированы?', style: _txtStyle, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 900),
                                child: const RegistrationScreen()
                            )
                        );
                      },
                      color: const Color(0xFF37DAE7),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.teal)
                      ),
                      child: Text('ПЕРЕЙТИ К РЕГИСТРАЦИИ', style: _btnTxtStyle),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {

    if (_email.isEmpty || _password.isEmpty) {

      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
                'Все поля должны быть заполнены!',
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
                  Navigator.pop(context);
                },
                child: const Text('Ок',
                    style: TextStyle(
                        color: Color(0xFF47B5FF),
                        fontSize: 22)),
              ),
            ],
          ));

    } else {

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.trim(),
            password: _password.trim()
        );

        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                  'Добро пожаловать!',
                  style: TextStyle(
                      color: Color(0xFF256D85),
                      fontSize: 22),
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
                    Navigator.pop(context);
                  },
                  child: const Text('Ок',
                      style: TextStyle(
                          color: Color(0xFF47B5FF),
                          fontSize: 22)),
                ),
              ],
            ));

      } on FirebaseAuthException catch (e) {

        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                  'Невалидные email или пароль',
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
                    Navigator.pop(context);
                  },
                  child: const Text('Ок',
                      style: TextStyle(
                          color: Color(0xFF47B5FF),
                          fontSize: 22)),
                ),
              ],
            ));

      }

    }

  }




}

