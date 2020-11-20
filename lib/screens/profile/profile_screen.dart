import 'package:flutter/material.dart';
import 'package:fluttertravelman/models/user_model.dart';
import 'package:fluttertravelman/screens/profile/edit_profile_screen.dart';
import 'package:fluttertravelman/utils/const.dart';
import 'package:getwidget/components/loader/gf_loader.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  final String currentUserId;

  ProfileScreen({this.userId, this.currentUserId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _profileDetails(UserModel user) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                // Текст имя
                                user.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: user.id != widget.currentUserId
                                      ? false
                                      : true,
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                      ),
                                      onPressed: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        EditProfileScreen(
                                                            user: user)))
                                          }),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.blueGrey[300],
                            ),
                            SizedBox(width: 3),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                // Местополодение
                                user.location ?? ' -- ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.blueGrey[300],
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // Возраст
                            user.age,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.blueGrey[300]),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Обо мне",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            //Текст обо мне
                            user.bio,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.left,
                          ),
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
    return Scaffold(
      body: FutureBuilder(
          future: usersRef.doc(widget.userId).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: GFLoader(),
              );
            }
            UserModel user = UserModel.fromDoc(snapshot.data);
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      user.profileImageUrl ?? 'assets/images/ph.png'),
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
                      child: _profileDetails(user),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
