import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ToursScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color pinBlue = Color.fromARGB(255, 57, 90, 255);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 50,
              left: 20,
              child: Text(
                'Trips',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, fontSize: 26),
              )),
          Positioned(
              top: 110,
              left: 20,
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.solidDotCircle,
                    color: pinBlue,
                    size: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Search by places',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.black38),
                  ),
                  SizedBox(
                    width: 210,
                  ),
                  Icon(
                    FontAwesomeIcons.search,
                    color: Colors.black38,
                    size: 15,
                  )
                ],
              )),
          Positioned(
              top: 180,
              left: 20,
              child: Text(
                'Offers',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, fontSize: 26),
              )),
          Positioned(
              top: 225,
              left: 20,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/ava_2.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/offer.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )),
          Positioned(
              top: 325,
              left: 20,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/ava_2.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/offer.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
