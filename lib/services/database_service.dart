import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertravelman/models/lead_model.dart';
import 'package:fluttertravelman/models/like_model.dart';
import 'package:fluttertravelman/models/post_model.dart';
import 'package:fluttertravelman/models/user_model.dart';

import '../utils/const.dart';

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
      'fromPlace': lead.fromPlace,
      'toPlace': lead.toPlace,
      'comment': lead.comment,
      'authorId': lead.authorId,
      'timestamp': lead.timestamp,
      'fromDate': lead.fromDate,
      'toDate': lead.toDate,
      'type': lead.type,
      'userName': lead.userName,
      'userPhone': lead.userPhone,
      'email': lead.email,
    });
  }

  static void postLike(
      DocumentReference reference, String name, String id, String profileImg) {
    var _like = Like(
        ownerName: name,
        ownerPhotoUrl: profileImg,
        ownerUid: id,
        timeStamp: FieldValue.serverTimestamp());
    reference.collection('likes').doc(id).set(_like.toMap(_like)).then((value) {
      print("Post Liked");
    });
  }

  static void postUnlike(
      DocumentReference reference, UserModel currentUser, String id) {
    reference.collection("likes").doc(id).delete().then((value) {
      print("Post Unliked");
    });
  }
}
