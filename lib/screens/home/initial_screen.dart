import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'file:///C:/Users/Azamatig/Desktop/Downloads/flutter_travelman/lib/screens/home/home_screen.dart';
import 'file:///C:/Users/Azamatig/Desktop/Downloads/flutter_travelman/lib/screens/home/enter_app_screen.dart';
import 'package:fluttertravelman/screens/home/Login_screen.dart';
import 'package:fluttertravelman/screens/home/Sign_up_screen.dart';
import 'package:provider/provider.dart';

import '../post/feed.dart';
import '../../models/user_data.dart';

class InitialScreen extends StatelessWidget {
  Widget _getScreenId() {
    return StreamBuilder<auth.User>(
      stream: auth.FirebaseAuth.instance.authStateChanges(),
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
