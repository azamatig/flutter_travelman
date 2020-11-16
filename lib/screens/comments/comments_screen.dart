import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertravelman/models/comment.dart';
import 'package:fluttertravelman/models/user_model.dart';
import 'package:fluttertravelman/utils/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentsScreen extends StatefulWidget {
  final DocumentReference documentReference;
  final UserModel user;

  final String userId;
  CommentsScreen({this.documentReference, this.user, this.userId});

  @override
  _CommentsScreenState createState() =>
      _CommentsScreenState(documentReference, user, userId);
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController _commentController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  final DocumentReference documentReference;
  final UserModel user;

  final String userId;

  _CommentsScreenState(this.documentReference, this.user, this.userId);

  @override
  void dispose() {
    super.dispose();
    _commentController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: new Color(0xfff8faf8),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            )),
        title: Text(
          'Комменты',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            commentsListWidget(),
            Divider(
              height: 20.0,
              color: Colors.grey,
            ),
            commentInputWidget()
          ],
        ),
      ),
    );
  }

  FutureBuilder commentInputWidget() {
    return FutureBuilder(
        future: usersRef.doc(userId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: GFLoader(),
            );
          }
          UserModel userImg = UserModel.fromDoc(snapshot.data);
          return Container(
            height: 55.0,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 4.0),
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      image: DecorationImage(
                          image: NetworkImage(userImg.profileImageUrl))),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextFormField(
                      // ignore: missing_return
                      validator: (String input) {
                        if (input.isEmpty) {
                          return "Please enter comment";
                        }
                      },
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: "Add a comment...",
                      ),
                      onFieldSubmitted: (value) {
                        _commentController.text = value;
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: Text('Post', style: TextStyle(color: Colors.blue)),
                  ),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      postComment(
                          userImg.name, userImg.profileImageUrl, userImg.id);
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  postComment(String userName, String profileImgUrl, String id) {
    var _comment = Comment(
        comment: _commentController.text,
        timeStamp: FieldValue.serverTimestamp(),
        ownerName: userName,
        ownerPhotoUrl: profileImgUrl,
        ownerUid: id);
    widget.documentReference
        .collection("comments")
        .doc()
        .set(_comment.toMap(_comment))
        .whenComplete(() {
      _commentController.text = "";
    });
  }

  Widget commentsListWidget() {
    return Flexible(
      child: StreamBuilder(
        stream: widget.documentReference
            .collection("comments")
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: ((context, index) =>
                  commentItem(snapshot.data.docs[index])),
            );
          }
        }),
      ),
    );
  }

  Widget commentItem(DocumentSnapshot snapshot) {
    /*  var time;
    List<String> dateAndTime;
    print('${snapshot.data()['timestamp'].toString()}');
    if (snapshot.data()['timestamp'].toString() != null) {
      Timestamp timestamp = snapshot.data()['timestamp'];
      print('${timestamp.seconds}');
      print('${timestamp.toDate()}');
      time = timestamp.toDate().toString();
      dateAndTime = time.split(" ");
    }*/

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data()['ownerPhotoUrl']),
              radius: 20,
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Row(
            children: <Widget>[
              Text(snapshot.data()['ownerName'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(snapshot.data()['comment']),
              ),
            ],
          )
        ],
      ),
    );
  }
}
