import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
final storageRef = FirebaseStorage.instance.ref();
final usersRef = _firestore.collection('users');
final postsRef = _firestore.collection('post');
final leadsRef = _firestore.collection('leads');
final Color buttonColor = Color.fromARGB(255, 255, 213, 0);
final Color pinBlue = Color.fromARGB(255, 57, 90, 255);
final Color pinYellow = Color.fromARGB(255, 255, 213, 0);
final String collectionDbName = 'instagram_stories_db';
final storiesRef = _firestore.collection(collectionDbName);

String formatOnlyDate(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('dd.MM.yyyy').format(dateTime);
}

String formatDate(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
}

String formatHour(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('HH:mm').format(dateTime);
}

String readTimeStamp(DateTime date) {
  var format = new DateFormat.Hm(); // My Format 08:00

  return format.format(date);
}
