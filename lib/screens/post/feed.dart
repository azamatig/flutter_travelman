import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fluttertravelman/models/user_model.dart';
import 'package:fluttertravelman/screens/chat_app/Blabla_screen.dart';
import 'package:fluttertravelman/screens/comments/comments_screen.dart';
import 'package:fluttertravelman/screens/home/likes_screen.dart';
import 'package:fluttertravelman/screens/offers/poisk_biletov.dart';
import 'package:fluttertravelman/screens/post/post_details_screen.dart';
import 'package:fluttertravelman/services/repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertravelman/services/database_service.dart';

class FeedScreen extends StatefulWidget {
  static final String id = 'feed_screen';
  final String userId;
  final String name;
  final String profileImgUrl;

  FeedScreen({Key key, this.userId, this.name, this.profileImgUrl})
      : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final db = FirebaseFirestore.instance;
  var _repository = Repository();
  UserModel currentUser, user, followingUser;
  List<String> followingUIDs = List<String>();
  List<UserModel> usersList = List<UserModel>();
  bool _isLiked = false;
  Future<List<DocumentSnapshot>> _future;

  DocumentReference reference;
  static String collectionDbName = 'stories';
  CollectionReference dbInstance =
      FirebaseFirestore.instance.collection(collectionDbName);

  void fetchFeed() async {
    auth.User currentUser = await _repository.getCurrentUser();

    UserModel user = await _repository.fetchUserDetailsById(currentUser.uid);
    setState(() {
      this.currentUser = user;
    });

    followingUIDs = await _repository.fetchFollowingUids(currentUser);

    for (var i = 0; i < followingUIDs.length; i++) {
      // _future = _repository.retrievePostByUID(followingUIDs[i]);
      this.user = await _repository.fetchUserDetailsById(followingUIDs[i]);
      usersList.add(this.user);

      for (var i = 0; i < usersList.length; i++) {
        setState(() {
          followingUser = usersList[i];
        });
      }
    }
    _future = _repository.fetchFeed(currentUser);
  }

  Container buildItem(DocumentSnapshot doc) {
    return Container(
      child: FutureBuilder(
          future: _future,
          builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: 5, top: 15),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              child: ClipOval(
                                child: Image.network(
                                  doc.data()['ownerImgUrl'],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text(
                                doc.data()['username'] ?? '-',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                            child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.ellipsisH,
                            size: 20,
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => PostDetails(
                                                  userId: doc.data()['ownerId'],
                                                  desc:
                                                      doc.data()['description'],
                                                  imgUrl:
                                                      doc.data()['mediaUrl'],
                                                  documentReference:
                                                      doc.reference,
                                                  currentUser: currentUser,
                                                )));
                                  },
                                  child: Container(
                                    height: 350,
                                    width: 400,
                                    child: Image.network(
                                      doc.data()['mediaUrl'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 20,
                                  child: Text(
                                    doc.data()['location'],
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            FutureBuilder(
                              future: _repository.fetchPostLikes(doc.reference),
                              builder: ((context,
                                  AsyncSnapshot<List<DocumentSnapshot>>
                                      likesSnapshot) {
                                if (likesSnapshot.hasData) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  LikesScreen(
                                                    user: currentUser,
                                                    documentReference:
                                                        doc.reference,
                                                  ))));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: likesSnapshot.data.length > 1
                                          ? Text(
                                              "Нравится ${likesSnapshot.data[0].data()['ownerName']} и ${(likesSnapshot.data.length - 1).toString()} другие",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(likesSnapshot.data.length == 1
                                              ? "Нравится ${likesSnapshot.data[0].data()['ownerName']}"
                                              : "0 Нравится"),
                                    ),
                                  );
                                } else {
                                  return Center(child: SizedBox());
                                }
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                doc.data()['description'],
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                            ),
                            commentWidget(doc.reference),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, left: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!_isLiked) {
                                        setState(() {
                                          _isLiked = true;
                                        });
                                        // saveLikeValue(_isLiked);
                                        DatabaseService.postLike(
                                            doc.reference,
                                            widget.name,
                                            widget.userId,
                                            widget.profileImgUrl);
                                      } else {
                                        setState(() {
                                          _isLiked = false;
                                        });
                                        //saveLikeValue(_isLiked);
                                        DatabaseService.postUnlike(
                                            doc.reference,
                                            currentUser,
                                            widget.userId);
                                      }
                                    },
                                    child: _isLiked
                                        ? Container(
                                            width: 40,
                                            height: 35,
                                            child: Icon(
                                              FontAwesomeIcons.heart,
                                              size: 20,
                                            ))
                                        : Container(
                                            width: 40,
                                            height: 35,
                                            child: Icon(
                                              FontAwesomeIcons.heart,
                                              color: Colors.red,
                                              size: 20,
                                            )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                      width: 40,
                                      height: 35,
                                      child: Icon(
                                        FontAwesomeIcons.shareAlt,
                                        size: 20,
                                      )),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => CommentsScreen(
                                                    userId: widget.userId,
                                                    documentReference:
                                                        doc.reference,
                                                    user: currentUser,
                                                  )));
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: 50,
                                      height: 35,
                                      child: Icon(
                                        FontAwesomeIcons.commentAlt,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget commentWidget(DocumentReference reference) {
    return FutureBuilder(
      future: _repository.fetchPostComments(reference),
      builder: ((context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5, top: 5),
            child: GestureDetector(
              child: Text(
                'Просмотреть ${snapshot.data.length} комментариев',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CommentsScreen(
                              userId: widget.userId,
                              documentReference: reference,
                              user: currentUser,
                            ))));
              },
            ),
          );
        } else {
          return Center(child: SizedBox());
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'travelman',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.telegramPlane,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(myId: widget.userId))),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PoiskBiletov(
                          userId: widget.userId,
                        ))),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('posts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.docs
                        .map((doc) => buildItem(doc))
                        .toList(),
                  );
                }
                return SizedBox();
              }),
        ],
      ),
    );
  }
}
