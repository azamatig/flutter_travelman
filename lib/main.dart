import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:getwidget/getwidget.dart';

import 'screens/initial_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return GFLoader();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return InitialScreen();
          }
          return GFLoader(type: GFLoaderType.ios);
        });
  }
}
