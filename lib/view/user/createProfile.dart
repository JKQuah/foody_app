import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:foody_app/model/location_dto.dart';
import 'package:foody_app/model/meat_model.dart';
import 'package:foody_app/model/preference_model.dart';
import 'package:foody_app/model/profile_model.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/services/meatHTTPService.dart';
import 'package:foody_app/services/preferenceHTTPService.dart';
import 'package:foody_app/services/userService.dart';
import 'package:foody_app/utils/convertUtils.dart';
import 'package:foody_app/utils/validatorUtils.dart';
import 'package:foody_app/view/loginView.dart';
import 'package:foody_app/view/meat/meatViewAll.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../indexView.dart';

class ProfileCreate extends StatefulWidget {
  ProfileCreate({Key key}) : super(key: key);

  @override
  _ProfileCreateState createState() => _ProfileCreateState();
}

class _ProfileCreateState extends State<ProfileCreate> {
  final _formKey = GlobalKey<FormState>();
  final ProfileModel profileModel = new ProfileModel();
  final _picker = ImagePicker();
  dynamic imageUrl = "";
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: AppConstants.googleApiKey);

  Future<List<PreferenceModel>> preferenceList;

  final TextEditingController bioCtl = TextEditingController();
  final TextEditingController locationCtl = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    preferenceList = PreferenceHTTPService.getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Complete Your Profile',
            style: TextStyle(
              fontFamily: 'Nexa',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder<List<PreferenceModel>>(
          future: preferenceList,
          builder: (context, AsyncSnapshot<List<PreferenceModel>> snapshot) {
            if (snapshot.hasData) {
              List<PreferenceModel> snapshotPreferences =
                  snapshot.data as List<PreferenceModel>;
              return SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      (imageUrl is Uint8List)
                          ? Image.memory(imageUrl)
                          : Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 50),
                                child: Text(
                                  "Please Add An Image",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                      FlatButton.icon(
                        icon: Icon(Icons.add_a_photo),
                        label: Text("Upload an Image"),
                        onPressed: () => {_selectImage(context, profileModel)},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: bioCtl,
                        decoration: InputDecoration(labelText: 'Bio'),
                        onSaved: (val) =>
                            setState(() => profileModel.biography = val),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ChipsInput(
                        initialValue: [],
                        decoration: InputDecoration(
                          labelText: "Preferences",
                        ),
                        maxChips: 3,
                        findSuggestions: (String query) {
                          if (query.length != 0) {
                            var lowercaseQuery = query.toLowerCase();
                            return snapshotPreferences.where((preference) {
                              return preference.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase());
                            }).toList(growable: false)
                              ..sort((a, b) => a.name
                                  .toLowerCase()
                                  .indexOf(lowercaseQuery)
                                  .compareTo(b.name
                                      .toLowerCase()
                                      .indexOf(lowercaseQuery)));
                          } else {
                            return const [];
                          }
                        },
                        onChanged: (data) {
                          setState(() {
                            profileModel.preferences =
                                data.cast<PreferenceModel>();
                          });
                        },
                        chipBuilder: (context, state, preference) {
                          return InputChip(
                            key: ObjectKey(preference),
                            label: Text(preference.name),
                            onDeleted: () => state.deleteChip(preference),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          );
                        },
                        suggestionBuilder: (context, state, profile) {
                          return ListTile(
                            key: ObjectKey(profile),
                            title: Text(profile.name),
                            onTap: () => state.selectSuggestion(profile),
                          );
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          border: const OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.location_pin,
                            color: AppColors.TEXT_COLOR,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.PRIMARY_COLOR, width: 1.5),
                          ),
                        ),
                        readOnly: true,
                        controller: locationCtl,
                        validator: requiredValidation,
                        onTap: () async {
                          Prediction p = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: AppConstants.googleApiKey,
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
                              profileModel.locationDTO = new LocationDTO(
                                  latitude: lat,
                                  longitude: lng,
                                  locationName: name,
                                  locationAddress: address);
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.PRIMARY_COLOR),
                          ),
                          onPressed: () => handleSubmit(context, profileModel),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.save,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Create",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ));
  }

  String requiredValidation(value) {
    if (ValidatorUtils.isEmpty(value)) {
      return 'This field is required';
    }
    return null;
  }

  String maxParticipantValidation(value) {
    if (ValidatorUtils.isEmpty(value)) {
      return 'This field is required';
    }
    if (!ValidatorUtils.isInteger(value)) {
      return 'This field cannot have decimal point';
    }
    if (ValidatorUtils.isNegativeNumber(value)) {
      return 'This field does not accept negative number';
    }
    return null;
  }

  void handleSubmit(BuildContext context, ProfileModel profileModel) async {
    final form = _formKey.currentState;
    if (form.validate()) {
      // print(profileModel.preferences.length);
      form.save();
      try {
        print(profileModel.toJson());
        await UserService.createProfile(profileModel);
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: AppColors.PRIMARY_COLOR,
            content: Text("Profile Created Successfully")));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginView()));
      } on Exception catch (_) {
        print("create create profile HTTP fail");
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: AppColors.DANGER_COLOR,
            content: Text("Fail to create profile ")));
      }
    }
  }

  _selectImage(BuildContext parentContext, ProfileModel profileModel) async {
    return showDialog<Null>(
      context: parentContext,
      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Image'),
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
                  String base64Url =
                      await ConvertUtils.fromPickedFileToBase64Url(imageFile);
                  Uint8List base64Content = await imageFile.readAsBytes();
                  setState(() {
                    profileModel.imageUrl = base64Url;
                    imageUrl = base64Content;
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
                  String base64Url =
                      await ConvertUtils.fromPickedFileToBase64Url(imageFile);
                  Uint8List base64Content = await imageFile.readAsBytes();
                  setState(() {
                    profileModel.imageUrl = base64Url;
                    imageUrl = base64Content;
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
}
