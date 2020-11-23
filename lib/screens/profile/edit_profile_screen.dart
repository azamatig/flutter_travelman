import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertravelman/models/user_model.dart';
import 'package:fluttertravelman/services/auth_service.dart';
import 'package:fluttertravelman/services/firebase_provider.dart';
import 'package:fluttertravelman/services/storage_service.dart';
import 'package:fluttertravelman/utils/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File _profileImage;
  String _name = '';
  String _bio = '';
  String _age = '';
  String _location = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
    _age = widget.user.age;
    _location = widget.user.location;
  }

  _handleImageFromGallery() async {
    var pick = ImagePicker();
    var imageFile;
    PickedFile pickedFile = (await pick.getImage(source: ImageSource.gallery));
    imageFile = File(pickedFile.path);
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayProfileImage() {
    // No new profile image
    if (_profileImage == null) {
      // No existing profile image
      if (widget.user.profileImageUrl.isEmpty) {
        // Display placeholder
        return AssetImage('assets/images/profile_photo.jpg');
      } else {
        // User profile image exists
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    } else {
      // New profile image
      return FileImage(_profileImage);
    }
  }

  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      // Update user in database
      String _profileImageUrl = '';

      if (_profileImage == null) {
        _profileImageUrl = widget.user.profileImageUrl;
      } else {
        _profileImageUrl = await StorageService.uploadUserProfileImage(
          widget.user.profileImageUrl,
          _profileImage,
        );
      }

      UserModel user = UserModel(
          id: widget.user.id,
          name: _name,
          profileImageUrl: _profileImageUrl,
          bio: _bio,
          age: _age,
          location: _location);
      // Database update
      FirebaseProvider.updateUser(user);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            )),
        title: Text(
          'Редактировать профиль',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                color: pinBlue,
              ),
              onPressed: () => {
                    AuthService.logout(),
                  }),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading
                ? LinearProgressIndicator(
                    backgroundColor: Colors.blue[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: _displayProfileImage(),
                    ),
                    FlatButton(
                      onPressed: _handleImageFromGallery,
                      child: Text(
                        'Загрузить фото профиля',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: pinBlue),
                      ),
                    ),
                    TextFormField(
                      initialValue: _name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          size: 30.0,
                        ),
                        labelText: 'ФИО',
                      ),
                      validator: (input) => input.trim().length < 1
                          ? 'Пожалуйста введите действительное ФИО'
                          : null,
                      onSaved: (input) => _name = input,
                    ),
                    TextFormField(
                      initialValue: _bio,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.book,
                          size: 30.0,
                        ),
                        labelText: 'Обо мне',
                      ),
                      validator: (input) => input.trim().length > 150
                          ? 'Не больше 150 символов'
                          : null,
                      onSaved: (input) => _bio = input,
                    ),
                    TextFormField(
                      initialValue: _age,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_circle,
                          size: 30.0,
                        ),
                        labelText: 'Возраст',
                      ),
                      validator: (input) =>
                          input.trim().length < 1 ? 'Введите возраст' : null,
                      onSaved: (input) => _age = input,
                    ),
                    TextFormField(
                      initialValue: _location,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.pin_drop,
                          size: 30.0,
                        ),
                        labelText: 'Местоположение',
                      ),
                      validator: (input) => input.trim().length < 1
                          ? 'Пожалуйста введите действительно местоположение'
                          : null,
                      onSaved: (input) => _location = input,
                    ),
                    Container(
                      margin: EdgeInsets.all(40.0),
                      height: 50.0,
                      width: 250.0,
                      child: GFButton(
                        onPressed: _submit,
                        color: pinBlue,
                        shape: GFButtonShape.pills,
                        textColor: Colors.white,
                        child: Text(
                          'Сохранить',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
