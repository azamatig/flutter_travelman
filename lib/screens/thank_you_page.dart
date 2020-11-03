import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color pinBlue = Color.fromARGB(255, 57, 90, 255);
    return Scaffold(
      body: Container(
          child: Padding(
        padding: const EdgeInsets.only(top: 150.0),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green,
                child: Icon(
                  FontAwesomeIcons.check,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Thank you! \n Your booking has been sent, \n operator will contact you soon.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      child: GFButton(
                        color: pinBlue,
                        size: 60,
                        shape: GFButtonShape.pills,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      'Back',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
