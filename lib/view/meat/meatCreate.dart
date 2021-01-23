import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:foody_app/model/meat_model.dart';
import 'package:foody_app/model/preference_model.dart';
import 'package:foody_app/services/meatHTTPService.dart';
import 'package:foody_app/services/preferenceHTTPService.dart';
import 'package:foody_app/utils/dateUtils.dart';
import 'package:foody_app/utils/validatorUtils.dart';
import 'package:intl/intl.dart';
import 'package:foody_app/widget/app_bar.dart';

class MeatCreate extends StatefulWidget {
  MeatCreate({Key key}) : super(key: key);

  @override
  _MeatCreateState createState() => _MeatCreateState();
}

class _MeatCreateState extends State<MeatCreate> {
  final _formKey = GlobalKey<FormState>();
  final _chipsKey = GlobalKey<ChipsInputState<int>>();
  MeatModel meatModel = MeatModel();
  List<PreferenceModel> preferenceList = [];

  final TextEditingController titleCtl = TextEditingController();
  final TextEditingController descriptionCtl = TextEditingController();
  final TextEditingController startDateCtl = TextEditingController();
  final TextEditingController startTimeCtl = TextEditingController();
  final TextEditingController endDateCtl = TextEditingController();
  final TextEditingController endTimeCtl = TextEditingController();
  final TextEditingController maxParticipantCtl = TextEditingController();

  @override
  void didChangeDependencies() async {
    preferenceList = await PreferenceHTTPService.getPreferences();
    meatModel = await MeatHTTPService.getOneMeat(43);
    print(meatModel.toJson());
    titleCtl.text = meatModel.title;
    descriptionCtl.text = meatModel.description;
    startDateCtl.text = DateUtils.fromDateTimeToDateStr(meatModel.startTime);
    startTimeCtl.text = DateUtils.fromDateTimeToTimeStr(meatModel.startTime);
    endDateCtl.text = DateUtils.fromDateTimeToDateStr(meatModel.endTime);
    endTimeCtl.text = DateUtils.fromDateTimeToTimeStr(meatModel.endTime);
    maxParticipantCtl.text = meatModel.maxParticipant.toString();
    Future.delayed(const Duration(milliseconds: 2000),
        () => meatModel.preferences.forEach((element) {
          _chipsKey.currentState.selectSuggestion(element.id);
          // addChip(element.id);
        }));

    super.didChangeDependencies();
  }

  // void addChip(int chip) {
  //   _chipsKey.currentState.selectSuggestion(chip);
  // }

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
      body: Builder(
        builder: (context) =>
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                                  decoration:
                                  InputDecoration(labelText: 'Start Date *'),
                                  controller: startDateCtl,
                                  validator: requiredValidation,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    // Show Date Picker Here
                                    DateTime date = await showDatePicker(
                                        context: context,
                                        initialDate: meatModel.startTime,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100));

                                    startDateCtl.text =
                                        DateUtils.fromDateTimeToDateStr(date);

                                    setState(() {
                                      meatModel.startTime = new DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          meatModel.startTime.hour,
                                          meatModel.startTime.minute);
                                    });
                                  }),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                  decoration:
                                  InputDecoration(labelText: 'Start Time *'),
                                  controller: startTimeCtl,
                                  validator: requiredValidation,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    // Show Date Picker Here
                                    TimeOfDay timeOfDay = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            meatModel.startTime));

                                    startTimeCtl.text =
                                        timeOfDay.format(context);

                                    setState(() {
                                      meatModel.startTime = new DateTime(
                                          meatModel.startTime.year,
                                          meatModel.startTime.month,
                                          meatModel.startTime.day,
                                          timeOfDay.hour,
                                          timeOfDay.minute);
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
                                  decoration:
                                  InputDecoration(labelText: 'End Date *'),
                                  controller: endDateCtl,
                                  validator: requiredValidation,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    // Show Date Picker Here
                                    DateTime date = await showDatePicker(
                                        context: context,
                                        initialDate: meatModel.endTime,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100));

                                    endDateCtl.text =
                                        DateFormat('yyyy-MM-dd').format(date);

                                    setState(() {
                                      meatModel.endTime = new DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          meatModel.endTime.hour,
                                          meatModel.endTime.minute);
                                    });
                                  }),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                  decoration:
                                  InputDecoration(labelText: 'End Time *'),
                                  controller: endTimeCtl,
                                  validator: requiredValidation,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    // Show Date Picker Here
                                    TimeOfDay timeOfDay = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            meatModel.endTime));

                                    endTimeCtl.text = timeOfDay.format(context);

                                    setState(() {
                                      meatModel.endTime = new DateTime(
                                          meatModel.endTime.year,
                                          meatModel.endTime.month,
                                          meatModel.endTime.day,
                                          timeOfDay.hour,
                                          timeOfDay.minute);
                                    });
                                  }),
                            )
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: maxParticipantCtl,
                        decoration: InputDecoration(
                            labelText: 'Max Participant *'),
                        keyboardType: TextInputType.number,
                        validator: maxParticipantValidation,
                        onSaved: (val) =>
                            setState(
                                    () =>
                                meatModel.maxParticipant = int.parse(val)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ChipsInput(
                        key: _chipsKey,
                        initialValue: [],
                        decoration: InputDecoration(
                          labelText: "Preferences",
                        ),
                        maxChips: 3,
                        findSuggestions: (String query) {
                          if (query.length != 0) {
                            var lowercaseQuery = query.toLowerCase();
                            return preferenceList.where((preference) {
                              return preference.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase());
                            }).toList(growable: false)
                              ..sort((a, b) =>
                                  a.name
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
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap,
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
                        decoration: InputDecoration(labelText: 'Image *'),
                        validator: requiredValidation,
                        // onSaved: (val) =>
                        //     setState(() => meatModel.imageUrl = val),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Location *'),
                        validator: requiredValidation,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => handleSubmit(context),
                          child: Text('Create'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
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

  void handleSubmit(BuildContext context) async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      try {
        print(meatModel.toJson());
        await MeatHTTPService.updateMeat(meatModel);
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Update Successfully")));
      } on Exception catch (_) {
        print("update meat HTTP fail");
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text("Fail to update")));
      }
    }
  }
}
