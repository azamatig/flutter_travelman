import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String profileImageUrl;
  final String email;
  final String bio;
  final String age;
  final String location;

  UserModel({
    this.id,
    this.name,
    this.profileImageUrl,
    this.email,
    this.bio,
    this.age,
    this.location,
  });

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
        id: doc.documentID,
        name: doc['name'],
        profileImageUrl: doc['profileImageUrl'],
        email: doc['email'],
        bio: doc['bio'] ?? '',
        age: doc['age'] ?? '',
        location: doc['location'] ?? 'Местоположение');
  }
}
