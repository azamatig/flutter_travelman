import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
final storageRef = FirebaseStorage.instance.ref();
final usersRef = _firestore.collection('users');
final postsRef = _firestore.collection('post');
final leadsRef = _firestore.collection('leads');
final Color buttonColor = Color.fromARGB(255, 255, 213, 0);
final Color pinBlue = Color.fromARGB(255, 57, 90, 255);
final Color pinYellow = Color.fromARGB(255, 255, 213, 0);

class Constants {
  static String myName = "";
}
