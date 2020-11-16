import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String profileImageUrl;
  String email;
  String bio;
  String age;
  String location;
  Map followers;
  Map following;
  String posts;
  String phone;
  bool isOperator;

  UserModel(
      {this.id,
      this.name,
      this.profileImageUrl,
      this.email,
      this.bio,
      this.age,
      this.location,
      this.followers,
      this.following,
      this.posts,
      this.phone,
      this.isOperator});

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      profileImageUrl: doc['profileImageUrl'],
      email: doc['email'],
      bio: doc['bio'] ?? '',
      age: doc['age'] ?? '',
      followers: doc['followers'],
      following: doc['following'],
      posts: doc['posts'] ?? '',
      phone: doc['phone'] ?? '',
      location: doc['location'] ?? 'Местоположение',
      isOperator: doc['isOperator'] ?? false,
    );
  }

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data['id'] = user.id;
    data['email'] = user.email;
    data['profileImageUrl'] = user.profileImageUrl;
    data['name'] = user.name;
    data['followers'] = user.followers;
    data['following'] = user.following;
    data['bio'] = user.bio;
    data['posts'] = user.posts;
    data['phone'] = user.phone;
    data['age'] = user.age;
    data['location'] = user.location;
    data['isOperator'] = user.isOperator;
    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    this.id = mapData['id'];
    this.email = mapData['email'];
    this.profileImageUrl = mapData['profileImageUrl'];
    this.name = mapData['name'];
    this.followers = mapData['followers'];
    this.following = mapData['following'];
    this.bio = mapData['bio'];
    this.age = mapData['age'];
    this.location = mapData['location'];
    this.posts = mapData['posts'];
    this.phone = mapData['phone'];
    this.isOperator = mapData['isOperator'];
  }
}
