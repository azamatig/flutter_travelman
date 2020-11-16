import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertravelman/models/lead_model.dart';
import 'package:fluttertravelman/models/user_data.dart';
import 'package:fluttertravelman/screens/offers/thank_you_page.dart';
import 'package:fluttertravelman/services/database_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:telebot/telebot.dart';

class PoiskBiletov extends StatefulWidget {
  @override
  _PoiskBiletovState createState() => _PoiskBiletovState();
}

var BOT_TOKEN = '1497250707:AAEgI_4vKieBUgoDkPFtSTbm7lk5gfaw9E4';
var bot = TelegramBot.init(BOT_TOKEN);

class _PoiskBiletovState extends State<PoiskBiletov> {
  String _fromPlace, _toPlace;
  String _type;
  TextEditingController _fromPlaceController = TextEditingController();
  TextEditingController _toPlaceController = TextEditingController();
  final Color pinYellow = Color.fromARGB(255, 255, 213, 0);
  final Color pinBlue = Color.fromARGB(255, 57, 90, 255);

  DateTime selectedDepDate = DateTime.now();
  DateTime selectedArrDate = DateTime.now();

  Future<Null> _selectDepDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDepDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDepDate)
      setState(() {
        selectedDepDate = picked;
      });
  }

  Future<Null> _selectArrDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedArrDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedArrDate)
      setState(() {
        selectedArrDate = picked;
      });
  }

  _addLead(context) {
    Lead lead = Lead(
      toPlace: _toPlace,
      fromPlace: _fromPlace,
      comment: 'lead from app',
      authorId: Provider.of<UserData>(context, listen: false).currentUserId,
      timestamp: Timestamp.fromDate(DateTime.now()),
      toDate: selectedDepDate,
      fromDate: selectedArrDate,
      type: _type,
    );
    DatabaseService.createLead(lead);
    bot
        .sendMessage(
            chatId: "-482276315",
            text:
                "Lead: \n Откуда: $_toPlace \n Куда: $_fromPlace \n Вылет: $selectedArrDate \n Прилет: $selectedDepDate \n Тип: $_type")
        .then((Message messageResult) {
      // got result
    }).catchError((error) {
      // handle error
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 250,
                    child: TextField(
                      controller: _fromPlaceController,
                      style: TextStyle(fontSize: 13.0),
                      decoration: InputDecoration(
                          labelText: 'Введите страну вылета',
                          labelStyle: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          )),
                      onChanged: (input) => _fromPlace = input,
                    ),
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
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                      width: 250,
                      child: TextField(
                        controller: _toPlaceController,
                        style: TextStyle(fontSize: 13.0),
                        decoration: InputDecoration(
                            labelText: 'Введите страну прилета',
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            )),
                        onChanged: (input) => _toPlace = input,
                      )),
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
              child: GestureDetector(
                onTap: () => _selectDepDate(context),
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
                      "Вылет " + "${selectedDepDate.toLocal()}".split(' ')[0],
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.grey[500]),
                    ),
                  ],
                ),
              )),
          Positioned(
              top: 350,
              left: 40,
              child: GestureDetector(
                onTap: () => _selectArrDate(context),
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
                      "Прилет " + "${selectedArrDate.toLocal()}".split(' ')[0],
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.grey[500]),
                    ),
                  ],
                ),
              )),
          Positioned(
              bottom: 370,
              left: 40,
              child: Text(
                'Class',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black),
              )),
          Positioned(
              bottom: 290,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  _type = 'ECONOMY';
                },
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
                ),
              )),
          Positioned(
              bottom: 230,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  _type = 'BUSINESS';
                },
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
                onPressed: () async {
                  await _addLead(context);
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
            bottom: 90,
            left: 150,
            child: Text(
              'Отправить запрос',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
