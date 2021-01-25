import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:foody_app/model/location_dto.dart';
import 'package:foody_app/model/meat_model.dart';
import 'package:foody_app/model/preference_model.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/services/meatHTTPService.dart';
import 'package:foody_app/services/preferenceHTTPService.dart';
import 'package:foody_app/utils/convertUtils.dart';
import 'package:foody_app/utils/validatorUtils.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foody_app/widget/app_bar.dart';

class MeatCreate extends StatefulWidget {
  MeatCreate({Key key}) : super(key: key);

  @override
  _MeatCreateState createState() => _MeatCreateState();
}

class _MeatCreateState extends State<MeatCreate> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  MeatModel meatModel;
  dynamic imageUrl = "";
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: AppConstants.googleApiKey);

  Future<List<PreferenceModel>> preferenceList;
  bool _startTimeError = false;
  bool _endTimeError = false;

  final TextEditingController titleCtl = TextEditingController();
  final TextEditingController descriptionCtl = TextEditingController();
  final TextEditingController startDateCtl = TextEditingController();
  final TextEditingController startTimeCtl = TextEditingController();
  final TextEditingController endDateCtl = TextEditingController();
  final TextEditingController endTimeCtl = TextEditingController();
  final TextEditingController maxParticipantCtl = TextEditingController();
  final TextEditingController locationCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    meatModel  = new MeatModel();
    meatModel.startTime = new DateTime.now();
    meatModel.endTime = new DateTime.now();

    startDateCtl.text = ConvertUtils.fromDateTimeToDateStr(meatModel.startTime);
    startTimeCtl.text = ConvertUtils.fromDateTimeToTimeStr(meatModel.startTime);
    endDateCtl.text = ConvertUtils.fromDateTimeToDateStr(meatModel.endTime);
    endTimeCtl.text = ConvertUtils.fromDateTimeToTimeStr(meatModel.endTime);

    preferenceList = PreferenceHTTPService.getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
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
            'Create A Meet & Eat',
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
                        onPressed: () => {_selectImage(context, meatModel)},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: titleCtl,
                        decoration: InputDecoration(labelText: 'Title *'),
                        validator: requiredValidation,
                        onSaved: (val) => setState(() => meatModel.title = val),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: descriptionCtl,
                        decoration: InputDecoration(labelText: 'Description'),
                        onSaved: (val) =>
                            setState(() => meatModel.description = val),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Start Date *',
                                    errorText: _startTimeError
                                        ? 'this must be later than now'
                                        : null,
                                  ),
                                  controller: startDateCtl,
                                  validator: requiredValidation,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    // Show Date Picker Here
                                    DateTime date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100));

                                    startDateCtl.text =
                                        ConvertUtils.fromDateTimeToDateStr(
                                            date);

                                    DateTime newDateTime = new DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        meatModel.startTime.hour,
                                        meatModel.startTime.minute);
                                    setState(() {
                                      meatModel.startTime = newDateTime;
                                      _startTimeError =
                                          DateTime.now().isAfter(newDateTime);
                                      _endTimeError = newDateTime
                                          .isAfter(meatModel.endTime);
                                    });
                                  }),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Start Time *',
                                    errorText: _startTimeError
                                        ? 'this must be later than now'
                                        : null,
                                  ),
                                  controller: startTimeCtl,
                                  validator: requiredValidation,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    // Show Date Picker Here
                                    TimeOfDay timeOfDay = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());

                                    startTimeCtl.text =
                                        timeOfDay.format(context);
                                    DateTime newDateTime = new DateTime(
                                        meatModel.startTime.year,
                                        meatModel.startTime.month,
                                        meatModel.startTime.day,
                                        timeOfDay.hour,
                                        timeOfDay.minute);
                                    setState(() {
                                      meatModel.startTime = newDateTime;
                                      _startTimeError =
                                          DateTime.now().isAfter(newDateTime);
                                      _endTimeError = newDateTime
                                          .isAfter(meatModel.endTime);
                                    });
                                  }),
                            )
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'End Date *',
                                      errorText: _endTimeError
                                          ? 'End Date must be later than Start Date'
                                          : null,
                                    ),
                                    controller: endDateCtl,
                                    validator: requiredValidation,
                                    onTap: () async {
                                      // Below line stops keyboard from appearing
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());

                                      // Show Date Picker Here
                                      DateTime date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100));

                                      endDateCtl.text =
                                          DateFormat('yyyy-MM-dd').format(date);

                                      DateTime newDateTime = new DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          meatModel.endTime.hour,
                                          meatModel.endTime.minute);
                                      setState(() {
                                        meatModel.endTime = newDateTime;
                                        _endTimeError =
                                            meatModel.startTime != null &&
                                                meatModel.startTime
                                                    .isAfter(newDateTime);
                                      });
                                    })),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'End Time *',
                                    errorText: _endTimeError
                                        ? 'End Date must be later than Start Date'
                                        : null,
                                  ),
                                  controller: endTimeCtl,
                                  validator: requiredValidation,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    // Show Date Picker Here
                                    TimeOfDay timeOfDay = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());

                                    endTimeCtl.text = timeOfDay.format(context);

                                    DateTime newDateTime = new DateTime(
                                        meatModel.endTime.year,
                                        meatModel.endTime.month,
                                        meatModel.endTime.day,
                                        timeOfDay.hour,
                                        timeOfDay.minute);
                                    setState(() {
                                      meatModel.endTime = newDateTime;
                                      _endTimeError =
                                          meatModel.startTime != null &&
                                              meatModel.startTime
                                                  .isAfter(newDateTime);
                                    });
                                  }),
                            )
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: maxParticipantCtl,
                        decoration:
                            InputDecoration(labelText: 'Max Participant *'),
                        keyboardType: TextInputType.number,
                        validator: maxParticipantValidation,
                        onSaved: (val) => setState(
                            () => meatModel.maxParticipant = int.parse(val)),
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
                            meatModel.preferences =
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
                      SizedBox(
                        height: 20,
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
                              meatModel.locationDTO = new LocationDTO(
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
                          onPressed: () => handleSubmit(context, meatModel),
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

  void handleSubmit(BuildContext context, MeatModel meatModel) async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      try {
        print(meatModel.toJson());
        await MeatHTTPService.createMeat(meatModel);
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.PRIMARY_COLOR,
            content: Text("Create Successfully")));
      } on Exception catch (_) {
        print("create meat HTTP fail");
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.DANGER_COLOR,
            content: Text("Fail to create")));
      }
    }
  }

  _selectImage(BuildContext parentContext, MeatModel meatModel) async {
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
                    meatModel.imageUrl = base64Url;
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
                    meatModel.imageUrl = base64Url;
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
