import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertravelman/models/comment.dart';
import 'package:fluttertravelman/models/lead_model.dart';
import 'package:fluttertravelman/models/like_model.dart';
import 'package:fluttertravelman/models/message_model.dart';
import 'package:fluttertravelman/models/post_model.dart';
import 'package:fluttertravelman/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:fluttertravelman/utils/const.dart';

class FirebaseProvider {
  UserModel user;
  Post post;
  Like like;
  Message _message;
  Comment comment;
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StorageReference _storageReference;

  Future<List<DocumentSnapshot>> retrieveUserPosts(String userId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .doc(userId)
        .collection("posts")
        .get();
    return querySnapshot.docs;
  }

  Future<auth.User> getCurrentUser() async {
    auth.User currentUser;
    currentUser = _auth.currentUser;
    return currentUser;
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    StorageUploadTask storageUploadTask = _storageReference.putFile(imageFile);
    var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();
    return url;
  }

  Future<List<DocumentSnapshot>> fetchPostCommentDetails(
      DocumentReference reference) async {
    QuerySnapshot snapshot = await reference.collection("comments").get();
    return snapshot.docs;
  }

  Future<List<DocumentSnapshot>> fetchPostLikeDetails(
      DocumentReference reference) async {
    QuerySnapshot snapshot = await reference.collection("likes").get();
    return snapshot.docs;
  }

  Future<bool> checkIfUserLikedOrNot(
      String userId, DocumentReference reference) async {
    DocumentSnapshot snapshot =
        await reference.collection("likes").doc(userId).get();
    return snapshot.exists;
  }

  Future<List<DocumentSnapshot>> retrievePosts(auth.User user) async {
    List<DocumentSnapshot> list = List<DocumentSnapshot>();
    List<DocumentSnapshot> updatedList = List<DocumentSnapshot>();
    QuerySnapshot querySnapshot;
    QuerySnapshot snapshot = await _firestore.collection("users").get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      if (snapshot.docs[i].id != user.uid) {
        list.add(snapshot.docs[i]);
      }
    }
    for (var i = 0; i < list.length; i++) {
      querySnapshot = await list[i].reference.collection("posts").get();
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        updatedList.add(querySnapshot.docs[i]);
      }
    }
    // fetchSearchPosts(updatedList);
    return updatedList;
  }

  Future<List<String>> fetchAllUserNames(auth.User user) async {
    List<String> userNameList = List<String>();
    QuerySnapshot querySnapshot = await _firestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != user.uid) {
        userNameList.add(querySnapshot.docs[i].data()['name']);
      }
    }

    return userNameList;
  }

  Future<String> fetchUidBySearchedName(String name) async {
    String uid;
    List<DocumentSnapshot> uidList = List<DocumentSnapshot>();

    QuerySnapshot querySnapshot = await _firestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      uidList.add(querySnapshot.docs[i]);
    }
    for (var i = 0; i < uidList.length; i++) {
      if (uidList[i].data()['name'] == name) {
        uid = uidList[i].id;
      }
    }
    return uid;
  }

  Future<UserModel> fetchUserDetailsById(String uid) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").doc(uid).get();
    return UserModel.fromMap(documentSnapshot.data());
  }

  Future<void> followUser(
      {String currentUserId, String followingUserId}) async {
    var followingMap = Map<String, String>();
    followingMap['uid'] = followingUserId;
    await _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("following")
        .doc(followingUserId)
      ..set(followingMap);

    var followersMap = Map<String, String>();
    followersMap['uid'] = currentUserId;

    return _firestore
        .collection("users")
        .doc(followingUserId)
        .collection("followers")
        .doc(currentUserId)
        .set(followersMap);
  }

  Future<void> unFollowUser(
      {String currentUserId, String followingUserId}) async {
    await _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("following")
        .doc(followingUserId)
        .delete();

    return _firestore
        .collection("users")
        .doc(followingUserId)
        .collection("followers")
        .doc(currentUserId)
        .delete();
  }

  Future<bool> checkIsFollowing(String name, String currentUserId) async {
    bool isFollowing = false;
    String uid = await fetchUidBySearchedName(name);
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("following")
        .get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id == uid) {
        isFollowing = true;
      }
    }
    return isFollowing;
  }

  Future<List<DocumentSnapshot>> fetchStats({String uid, String label}) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection("users").doc(uid).collection(label).get();
    return querySnapshot.docs;
  }

  Future<void> updatePhoto(String photoUrl, String uid) async {
    Map<String, dynamic> map = Map();
    map['photoUrl'] = photoUrl;
    return _firestore.collection("users").doc(uid).update(map);
  }

  Future<void> updateDetails(
      String uid, String name, String bio, String email, String phone) async {
    Map<String, dynamic> map = Map();
    map['displayName'] = name;
    map['bio'] = bio;
    map['email'] = email;
    map['phone'] = phone;
    return _firestore.collection("users").doc(uid).update(map);
  }

  Future<List<String>> fetchUserNames(auth.User user) async {
    DocumentReference documentReference =
        _firestore.collection("messages").doc(user.uid);
    List<String> userNameList = List<String>();
    List<String> chatUsersList = List<String>();
    QuerySnapshot querySnapshot = await _firestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != user.uid) {
        userNameList.add(querySnapshot.docs[i].id);
        //querySnapshot.docs[i].reference.collection("collectionPath");
        //userNameList.add(querySnapshot.docs[i].data['displayName']);
      }
    }

    for (var i = 0; i < userNameList.length; i++) {
      if (documentReference.collection(userNameList[i]) != null) {
        if (documentReference.collection(userNameList[i]).get() != null) {
          chatUsersList.add(userNameList[i]);
        }
      }
    }

    return chatUsersList;

    // return userNameList;
  }

  Future<List<UserModel>> fetchAllUsers(auth.User user) async {
    List<UserModel> userList = List<UserModel>();
    QuerySnapshot querySnapshot = await _firestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != user.uid) {
        userList.add(UserModel.fromMap(querySnapshot.docs[i].data()));
        //userList.add(querySnapshot.docs[i].data[User.fromMap(mapData)]);
      }
    }
    return userList;
  }

  void uploadImageMsgToDb(String url, String receiverUid, String senderuid) {
    _message = Message.withoutMessage(
        receiverUid: receiverUid,
        senderUid: senderuid,
        photoUrl: url,
        timestamp: FieldValue.serverTimestamp(),
        type: 'image');
    var map = Map<String, dynamic>();
    map['senderUid'] = _message.senderUid;
    map['receiverUid'] = _message.receiverUid;
    map['type'] = _message.type;
    map['timestamp'] = _message.timestamp;
    map['photoUrl'] = _message.photoUrl;

    _firestore
        .collection("messages")
        .doc(_message.senderUid)
        .collection(receiverUid)
        .add(map)
        .whenComplete(() {});

    _firestore
        .collection("messages")
        .doc(receiverUid)
        .collection(_message.senderUid)
        .add(map)
        .whenComplete(() {});
  }

  Future<void> addMessageToDb(Message message, String receiverUid) async {
    var map = message.toMap();

    await _firestore
        .collection("messages")
        .doc(message.senderUid)
        .collection(receiverUid)
        .add(map);

    return _firestore
        .collection("messages")
        .doc(receiverUid)
        .collection(message.senderUid)
        .add(map);
  }

  Future<List<DocumentSnapshot>> fetchFeed(auth.User user) async {
    List<String> followingUIDs = List<String>();
    List<DocumentSnapshot> list = List<DocumentSnapshot>();

    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("following")
        .get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      followingUIDs.add(querySnapshot.docs[i].id);
    }

    for (var i = 0; i < followingUIDs.length; i++) {
      //retrievePostByUID(followingUIDs[i]);
      // fetchUserDetailsById(followingUIDs[i]);

      QuerySnapshot postSnapshot = await _firestore
          .collection("users")
          .doc(followingUIDs[i])
          .collection("posts")
          .get();
      // postSnapshot.docs;
      for (var i = 0; i < postSnapshot.docs.length; i++) {
        list.add(postSnapshot.docs[i]);
      }
    }

    return list;
  }

  Future<List<String>> fetchFollowingUids(auth.User user) async {
    List<String> followingUIDs = List<String>();

    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("following")
        .get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      followingUIDs.add(querySnapshot.docs[i].id);
    }

    for (var i = 0; i < followingUIDs.length; i++) {}
    return followingUIDs;
  }

  static void updateUser(UserModel user) {
    usersRef.doc(user.id).update({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'bio': user.bio,
      'age': user.age,
      'location': user.location,
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
    reference
        .collection('likes')
        .doc(id)
        .set(_like.toMap(_like))
        .then((value) {});
  }

  static void postUnlike(
      DocumentReference reference, UserModel currentUser, String id) {
    reference.collection("likes").doc(id).delete().then((value) {
      print("Post Unliked");
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
}
