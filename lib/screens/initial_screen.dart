import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fluttertravelman/screens/home_screen.dart';
import 'package:fluttertravelman/screens/Login_screen.dart';
import 'package:fluttertravelman/screens/enter_app_screen.dart';
import 'package:provider/provider.dart';

import 'Sign_up_screen.dart';
import 'feed.dart';
import '../models/user_data.dart';

class InitialScreen extends StatelessWidget {
  Widget _getScreenId() {
    return StreamBuilder<auth.User>(
      stream: auth.FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return MainScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'Travelman',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _getScreenId(),
        routes: {
          '/home': (context) => MainScreen(),
          EnterAppScreen.id: (context) => EnterAppScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          FeedScreen.id: (context) => FeedScreen(),
        },
      ),
    );
  }
}
