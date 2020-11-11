import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertravelman/models/user_data.dart';
import 'package:provider/provider.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  static final _fireStore = FirebaseFirestore.instance;

  static void signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User signedInUser = userCredential.user;
      if (signedInUser != null) {
        _fireStore.collection('/users').doc(signedInUser.uid).set({
          'name': name,
          'email': email,
          'id': signedInUser.uid,
          'profileImageUrl': '',
          'location': 'Не указано',
          'age': '',
          'bio': '',
          'followers': '',
          'following': '',
          'phone': '',
          'posts': '',
        });
        Provider.of<UserData>(context).currentUserId = signedInUser.uid;
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  static void logout() {
    FirebaseAuth.instance.signOut();
  }

  static void login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
}
