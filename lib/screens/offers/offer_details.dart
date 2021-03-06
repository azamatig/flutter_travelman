import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertravelman/models/user_model.dart';
import 'package:fluttertravelman/utils/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferDetails extends StatefulWidget {
  final String userId;
  final String desc;
  final String imgUrl;

  OfferDetails({this.userId, this.desc, this.imgUrl});

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  FutureBuilder _offerDetails() {
    return FutureBuilder(
        future: usersRef.doc(widget.userId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: GFLoader(),
            );
          }
          UserModel user = UserModel.fromDoc(snapshot.data);
          return SingleChildScrollView(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 15,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: user.profileImageUrl,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      // Текст имя
                                      user.name,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Container(
                                    child: Text(
                                      widget.desc,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.imgUrl),
          ),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Material(
                elevation: 14.0,
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
                shadowColor: Colors.grey,
                child: _offerDetails(),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                            width: 40,
                            height: 35,
                            child: Icon(FontAwesomeIcons.heart)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                            width: 40,
                            height: 35,
                            child: Icon(FontAwesomeIcons.shareAlt)),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, right: 20),
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: 75,
                          height: 35,
                          child: Icon(FontAwesomeIcons.bookmark),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
