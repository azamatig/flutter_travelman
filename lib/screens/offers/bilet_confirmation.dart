import 'package:flutter/material.dart';
import 'package:fluttertravelman/screens/offers/thank_you_page.dart';
import 'package:fluttertravelman/utils/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 57,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.chevronLeft, size: 20),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'back',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  ],
                ),
              )),
          Positioned(
              top: 50,
              right: 20,
              child: Text(
                'Lets add your trip',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, fontSize: 21),
              )),
          Positioned(
              top: 125,
              left: 40,
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    color: pinYellow,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'From  Almaty',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.grey[500]),
                  ),
                ],
              )),
          Positioned(
              top: 170,
              left: 40,
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    color: pinBlue,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'To  Oslo',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.grey[500]),
                  ),
                ],
              )),
          calendarBar(context),
          Positioned(
            bottom: 0,
            child: Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/int_2.png'),
              )),
            ),
          ),
          ticketCard(),
          Positioned(
              bottom: 135,
              left: 20,
              child: Container(
                width: 390,
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 20, 0, 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/avatar.jpg',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Bliss Air',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Row(
                        children: [
                          Text(
                            'OSL',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 157,
                          ),
                          Text(
                            'ALA',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '12:30, 5 NOV',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Text(
                            '12:30, 6 NOV',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/buy_icon.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Buy one way',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Spacer(),
                            Text(
                              '\$429',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
            bottom: 50,
            left: 185,
            child: Container(
              width: 40,
              child: GFButton(
                color: pinBlue,
                size: 40,
                shape: GFButtonShape.pills,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ThankYouPage()));
                },
                child: Icon(
                  FontAwesomeIcons.arrowRight,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 175,
            child: Text(
              'Book now',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget calendarBar(context) {
    Color pinBlue = Color.fromARGB(255, 57, 90, 255);
    return Stack(
      children: [
        Positioned(
            top: 240,
            child: Container(
              decoration: BoxDecoration(color: pinBlue, boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ]),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Center(
                child: Text(
                  'Wed 5 Nov \n Today',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
            )),
      ],
    );
  }
}

Widget ticketCard() {
  return Stack(
    children: [
      Positioned(
          bottom: 320,
          left: 20,
          child: Container(
            width: 390,
            height: 170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20, 0, 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/avatar.jpg',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Bliss Air',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Row(
                    children: [
                      Text(
                        'OSL',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 157,
                      ),
                      Text(
                        'ALA',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '12:30, 5 NOV',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        '12:30, 6 NOV',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/buy_icon.png',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Buy one way',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Spacer(),
                        Text(
                          '\$429',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    ],
  );
}
