import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foody_app/model/post_model.dart';
import 'package:foody_app/resource/app_colors.dart';
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
  PickedFile file;
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            // backgroundImage: ImageProvider('assets/lfoo.oobgb'),
                            radius: 34,
                          ),
                          Column(
                            children: [
                              FlatButton(
                                child: Text("Add Photo"),
                                onPressed: () => {_selectImage(context)},
                              )
                            ],
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
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
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
                      "Taste",
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
          title: const Text('Create a Post'),
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
                    file = imageFile;
                  });
                }),
            SimpleDialogOption(
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  PickedFile imageFile = await _picker.getImage(
                      source: ImageSource.camera,
                      maxWidth: 1080,
                      maxHeight: 1080,
                      imageQuality: 80);
                  setState(() {
                    file = imageFile;
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
              fontSize: 20,
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
                case "Taste":
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
}
