import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authorization_screen.dart';
import 'home_page.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Container(
    child: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const AuthorizationScreen();
        }
      },
    ),
  );
}



