// import 'dart:html';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:foody_app/model/locationDTO.dart';
import 'package:foody_app/model/post_model.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/services/postService.dart';
import 'package:foody_app/view/homeView.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({Key key}) : super(key: key);

  @override
  _AddPostViewState createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  PostModel _newpost = new PostModel();

  bool _loading;
  File _file;
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: AppConstants.GOOGLE_API_KEY);
  final TextEditingController locationCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.grey[900],
            size: 35,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Add New Post',
          style: TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _loading ? LinearProgressIndicator() : SizedBox(height: 4.5),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    right: 20.0,
                    left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: _file != null
                                ? Image.file(
                                    _file,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.fill,
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: 75,
                                    height: 75,
                                  ),
                          ),
                          _file == null
                              ? FlatButton(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                                      Text(" Add Photo"),
                                    ],
                                  ),
                                  onPressed: () => {_selectImage(context)},
                                )
                              : FlatButton(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                                      Text(" Change Photo"),
                                    ],
                                  ),
                                  onPressed: () => {_selectImage(context)},
                                ),
                        ],
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Write down your caption here',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.PRIMARY_COLOR, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Any comment on the food?';
                        } else {
                          setState(() {
                            _newpost.caption = value;
                          });
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: 'Where is the restaurant?',
                        border: const OutlineInputBorder(),
                        suffixIcon: Icon(Icons.location_pin),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.PRIMARY_COLOR, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the restaurant address';
                        }
                        return null;
                      },
                      controller: locationCtl,
                      onTap: () async {
                        Prediction p = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: AppConstants.GOOGLE_API_KEY,
                            mode: Mode.fullscreen,
                            // Mode.fullscreen
                            language: "en",
                            components: [
                              new Component(Component.country, "my")
                            ]);
                        if (p != null) {
                          PlacesDetailsResponse detail =
                              await _places.getDetailsByPlaceId(p.placeId);
                          double lat = detail.result.geometry.location.lat;
                          double lng = detail.result.geometry.location.lng;
                          String name = detail.result.name;
                          String address = detail.result.formattedAddress;

                          locationCtl.text = name;
                          setState(() {
                            _newpost.location = new LocationDTO(
                                latitude: lat,
                                longitude: lng,
                                locationName: name,
                                locationAddress: address);
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Rate the restaurant",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    _ratingCollapsed(
                      Icon(Icons.sentiment_satisfied_alt),
                      "Service",
                      _newpost.services,
                    ),
                    _ratingCollapsed(
                      Icon(Icons.cleaning_services_outlined),
                      "Cleanliness",
                      _newpost.cleanliness,
                    ),
                    _ratingCollapsed(
                      Icon(Icons.restaurant),
                      "Food",
                      _newpost.taste,
                    ),
                    _ratingCollapsed(
                      Icon(Icons.attach_money),
                      "Price",
                      _newpost.price,
                    ),
                    SizedBox(height: 15.0),
                    Center(
                      child: FlatButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            if (validateRating()) {
                              addPost(_newpost);
                            } else {
                              print('error');
                              setState(() {
                                _loading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        color: AppColors.PRIMARY_COLOR,
                        height: 50.0,
                        minWidth: 200.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog<Null>(
      context: parentContext,
      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add a Photo'),
          children: <Widget>[
            SimpleDialogOption(
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  PickedFile imageFile = await _picker.getImage(
                      source: ImageSource.camera,
                      maxWidth: 1080,
                      maxHeight: 1080,
                      imageQuality: 80);
                  setState(() {
                    if (imageFile != null) {
                      _file = File(imageFile.path);
                      List<int> imageBytes = _file.readAsBytesSync();
                      _newpost.postImages = base64Encode(imageBytes);
                    } else {
                      print('No image selected.');
                    }
                  });
                }),
            SimpleDialogOption(
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  PickedFile imageFile = await _picker.getImage(
                      source: ImageSource.gallery,
                      maxWidth: 1080,
                      maxHeight: 1080,
                      imageQuality: 80);
                  setState(() {
                    if (imageFile != null) {
                      _file = File(imageFile.path);
                      List<int> imageBytes = _file.readAsBytesSync();
                      _newpost.postImages = base64Encode(imageBytes);
                    } else {
                      print('No image selected.');
                    }
                  });
                }),
            SimpleDialogOption(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  _ratingCollapsed(Icon icon, String title, double score) {
    return ExpandablePanel(
      header: ListTile(
        leading: icon,
        title: Text(title,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        trailing: score == null ? Text("") : Text(score.toString()),
      ),
      expanded: Center(
        child: RatingBar(
          initialRating: 3,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: Image.asset('assets/heart.png'),
            half: Image.asset('assets/heart_half.png'),
            empty: Image.asset('assets/heart_border.png'),
          ),
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
            setState(() {
              switch (title) {
                case "Service":
                  _newpost.services = rating;
                  break;
                case "Cleanliness":
                  _newpost.cleanliness = rating;
                  break;
                case "Food":
                  _newpost.taste = rating;
                  break;
                case "Price":
                  _newpost.price = rating;
                  break;
                default:
                  break;
              }
            });
          },
        ),
      ),
    );
  }

  addPost(PostModel newPost) async {
    // ScrollController().animateTo(0.0,
    //     duration: Duration(milliseconds: 500), curve: Curves.ease);
    bool isPosted = await PostService().createPost(newPost);
    if (isPosted) {
      Navigator.pop(context, MaterialPageRoute(
        builder: (BuildContext context) {
          return HomeView();
        },
      ));
    } else {}
  }

  bool validateRating() {
    if (_newpost.services == null) {
      displaySnackBar("service");
      return false;
    } else if (_newpost.cleanliness == null) {
      displaySnackBar("cleanliness");
      return false;
    } else if (_newpost.taste == null) {
      displaySnackBar("food");
      return false;
    } else if (_newpost.price == null) {
      displaySnackBar("price");
      return false;
    }
    return true;
  }

  void displaySnackBar(String variable) {
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Please rating their ' + variable,
        style: TextStyle(fontSize: 16.0),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: AppColors.DANGER_COLOR,
    ));
  }
}
