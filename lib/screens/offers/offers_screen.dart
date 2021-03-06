import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluttertravelman/screens/offers/offer_details.dart';
import 'package:fluttertravelman/utils/const.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class OffersScreen extends StatefulWidget {
  static final String id = 'feed_screen';
  final String uid;
  final String userId;
  final String name;
  final String description;
  final String profileImgUrl;
  final String imageUrl;

  OffersScreen(
      {Key key,
      this.userId,
      this.uid,
      this.name,
      this.description,
      this.imageUrl,
      this.profileImgUrl})
      : super(key: key);

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final db = FirebaseFirestore.instance;

  Container buildItem(DocumentSnapshot doc) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5, top: 15),
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
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            height: 350,
                            width: 400,
                            child: CachedNetworkImage(
                              imageUrl: doc.data()['mediaUrl'] ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 20,
                            child: Text(
                              doc.data()['location'] ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ReadMoreText(
                          doc.data()['description'] ?? '',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                          trimLines: 2,
                          colorClickableText: Colors.blue,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Читать полностью',
                          trimExpandedText: 'меньше',
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 10),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  width: 40,
                                  height: 35,
                                  child: Icon(
                                    FontAwesomeIcons.heart,
                                    size: 20,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                                width: 40,
                                height: 35,
                                child: IconButton(
                                  icon:
                                      Icon(FontAwesomeIcons.shareAlt, size: 20),
                                  onPressed: () async {
                                    await FlutterShareMe().shareToWhatsApp(
                                        msg: 'ссылка на приложение');
                                  },
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 335,
                  left: 155,
                  child: Container(
                    width: 80,
                    height: 30,
                    child: GFButton(
                      shape: GFButtonShape.pills,
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OfferDetails(
                                      userId: widget.userId,
                                      desc: doc.data()['description'],
                                      imgUrl: doc.data()['mediaUrl'],
                                    )))
                      },
                      child: Text(
                        'Войти',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      color: pinYellow,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Предложения от туроператоров',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('offers').snapshots(),
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
