import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foody_app/model/meat_model.dart';
import 'package:foody_app/model/preference_model.dart';
import 'package:foody_app/services/meatHTTPService.dart';
import 'package:foody_app/utils/convertUtils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeatViewOne extends StatefulWidget {
  MeatViewOne({Key key}) : super(key: key);

  @override
  _MeatViewOneState createState() => _MeatViewOneState();
}

class _MeatViewOneState extends State<MeatViewOne> {
  Future<MeatModel> futureMeatModel;
  Completer<GoogleMapController> _controller = Completer();

  @override
  void didChangeDependencies() async {
    futureMeatModel = MeatHTTPService.getOneMeat(43);
    MeatModel meatModel = (await futureMeatModel);

    print(meatModel.toJson());

    super.didChangeDependencies();
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
          'Meat & Eat',
          style: TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<MeatModel>(
        future: futureMeatModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            MeatModel snapshotMeat = snapshot.data;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network("https://source.unsplash.com/user/erondu",
                        fit: BoxFit.fitWidth),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data.title,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Row(
                            children: snapshot.data.preferences
                                .map((PreferenceModel preference) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Chip(
                                        label: Text(preference.name),
                                      ),
                                    ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Text(
                              "Begin at: ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey,
                              ),
                            ),
                            Text(
                              ConvertUtils.formDateTimeToStr(
                                  snapshot.data.startTime),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Text(
                              "End at: ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey,
                              ),
                            ),
                            Text(
                              ConvertUtils.formDateTimeToStr(
                                  snapshot.data.endTime),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Location: ",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: GoogleMap(
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              markers: {
                                Marker(
                                    markerId: MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
                                    position: LatLng(
                                        snapshotMeat.locationDTO.latitude,
                                        snapshotMeat.locationDTO.longitude),
                                    infoWindow: InfoWindow(
                                        title: snapshotMeat
                                            .locationDTO.locationName))
                              },
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    snapshotMeat.locationDTO.latitude,
                                    snapshotMeat.locationDTO.longitude),
                                zoom: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: FlatButton.icon(
                        icon: Icon(Icons.supervised_user_circle),
                        label: Text(
                          "See Participants",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.green),
                        ),
                        onPressed: () => {print("see participants")},
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        snapshot.data.description,
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: buttonFactory(snapshotMeat),
              ),
            );
          } else if (snapshot.hasError) {
            throw snapshot.error;
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget buttonFactory(MeatModel meatModel) {
    if (meatModel.meatStatus == "cancelled") return CancelledText();
    if (meatModel.role == "organiser") return UpdateButton(meatModel.id);
    if (meatModel.userStatus == "going") return UnjoinButton(meatModel.id);
    return JoinButton(meatModel.id);
  }
}

class UpdateButton extends StatelessWidget {
  int meatId;

  UpdateButton(this.meatId);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        "Update",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
      ),
      onPressed: () async {
        // Navigator.push(context, route)
      },
    );
  }
}

class CancelledText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.center,
      direction: Axis.horizontal,
      children: [
        Text(
          "Meat & Eat is Cancelled",
          style: TextStyle(
            fontSize: 22,
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}

class JoinButton extends StatelessWidget {
  int meatId;

  JoinButton(this.meatId);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        "Join",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
      ),
      onPressed: () async {
        try {
          await MeatHTTPService.joinMeat(meatId);
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text("Join Successfully")));
        } on Exception catch (_) {
          print("join meat HTTP fail");
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text("Fail to join")));
        }
      },
    );
  }
}

class UnjoinButton extends StatelessWidget {
  int meatId;

  UnjoinButton(this.meatId);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        "Unjoin",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
      ),
      onPressed: () async {
        try {
          await MeatHTTPService.unjoinMeat(meatId);
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text("Unjoin Successfully")));
        } on Exception catch (_) {
          print("unjoin meat HTTP fail");
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text("Fail to unjoin")));
        }
      },
    );
  }
}