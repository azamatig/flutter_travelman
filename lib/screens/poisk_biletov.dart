import 'package:flutter/material.dart';
import 'file:///C:/Users/Azamatig/Desktop/Downloads/flutter_travelman/lib/screens/bilet_confirmation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class PoiskBiletov extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _fromPlace, _toPLace, _fromDate, _toDate;
  Color pinYellow = Color.fromARGB(255, 255, 213, 0);
  Color pinBlue = Color.fromARGB(255, 57, 90, 255);
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
                    'From',
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
                    'To',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.grey[500]),
                  ),
                ],
              )),
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
          Positioned(
              top: 250,
              left: 40,
              child: Row(
                children: [
                  Text(
                    'Dates',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ],
              )),
          Positioned(
              top: 300,
              left: 40,
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.calendarAlt,
                    color: Colors.black,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Departure date',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.grey[500]),
                  ),
                ],
              )),
          Positioned(
              top: 350,
              left: 40,
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.calendarAlt,
                    color: Colors.black,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Return date',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.grey[500]),
                  ),
                ],
              )),
          Positioned(
              bottom: 330,
              left: 40,
              child: Text(
                'Class',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black),
              )),
          Positioned(
              bottom: 250,
              left: 20,
              child: Container(
                color: Colors.white,
                width: 390,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.plane,
                        color: Colors.black,
                        size: 15,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Economy',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              bottom: 200,
              left: 20,
              child: Container(
                color: Colors.white,
                width: 390,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.plane,
                        color: Colors.black,
                        size: 15,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Business',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
            bottom: 120,
            left: 185,
            child: Container(
              width: 40,
              child: GFButton(
                color: pinBlue,
                size: 40,
                shape: GFButtonShape.pills,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicketConfirmation()));
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
            bottom: 90,
            left: 162,
            child: Text(
              'Search flights',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
