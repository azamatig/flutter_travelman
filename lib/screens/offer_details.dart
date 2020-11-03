import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferDetails extends StatefulWidget {
  final String userId;

  OfferDetails({this.userId});

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  Widget _profileDetails() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 350,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    height: 300,
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
                                child: Image.asset(
                                  'assets/images/ava_2.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              // Текст имя
                              'Jennifer',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                            ),
                            Spacer(),
                            Text(
                              // Текст имя
                              '9th Nov',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.black38),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Container(
                            child: Text(
                              "Going on a trip to America, looking for someone to join me on this epic journey through American lifestyle.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            height: 75,
                            width: 100,
                            child: Image.asset(
                              'assets/images/grp_1.png',
                            )),
                        SizedBox(height: 15),
                        Row(
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
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, right: 20),
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: 75,
                                height: 35,
                                child: Icon(FontAwesomeIcons.bookmark),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //
            //
            //
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = Color.fromARGB(255, 255, 213, 0);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/det_1.png'),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 57,
                left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.chevronLeft,
                          size: 20, color: Colors.white),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'back',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ],
                  ),
                )),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, bottom: 7),
                        child: Text(
                          'Bali',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0, bottom: 7),
                        child: Text(
                          'IN ROUTE',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: buttonColor),
                        ),
                      ),
                    ],
                  ),
                  Material(
                    elevation: 14.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0)),
                    shadowColor: Colors.grey,
                    child: _profileDetails(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
