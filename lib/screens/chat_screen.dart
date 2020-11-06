import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 50,
              left: 20,
              child: Text(
                'Search',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, fontSize: 26),
              )),
          Positioned(
              top: 110,
              left: 20,
              child: Row(
                children: [
                  Text(
                    'Search by user or places',
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
                'Chats',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, fontSize: 26),
              )),
          Positioned(
              top: 250,
              left: 20,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/ava_1.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Alex',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700, fontSize: 12),
                          ),
                          SizedBox(
                            width: 225,
                          ),
                          Text(
                            '9:45 AM',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      Text(
                        'Test message here',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              )),
          Positioned(
              top: 325,
              left: 20,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/ava_1.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'John',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700, fontSize: 12),
                          ),
                          SizedBox(
                            width: 225,
                          ),
                          Text(
                            '9:45 AM',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      Text(
                        'Lorem ipsum stuff and so on',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
