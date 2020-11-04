import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertravelman/models/lead_model.dart';
import 'package:fluttertravelman/models/post_model.dart';
import 'package:fluttertravelman/models/user_model.dart';

import '../const.dart';

class DatabaseService {
  static void updateUser(UserModel user) {
    usersRef.doc(user.id).update({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'bio': user.bio,
      'age': user.age,
      'location': user.location,
    });
  }

  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users =
        usersRef.where('name', isGreaterThanOrEqualTo: name).get();
    return users;
  }

  static void createPost(Post post) {
    postsRef.doc(post.authorId).collection('usersPosts').add({
      'imageUrl': post.imageUrl,
      'caption': post.caption,
      'likes': post.likes,
      'authorId': post.authorId,
      'timestamp': post.timestamp,
    });
  }

  static void createLead(Lead lead) {
    leadsRef.doc(lead.authorId).collection('userLeads').add({
      'imageUrl': lead.offerUrl,
      'caption': lead.comment,
      'likes': lead.likes,
      'authorId': lead.authorId,
      'timestamp': lead.timestamp,
    });
  }
}
