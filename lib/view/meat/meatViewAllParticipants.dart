import 'package:flutter/material.dart';
import 'package:foody_app/model/meat_participant_model.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/services/meatHTTPService.dart';
import 'package:foody_app/view/meat/meatUpdate.dart';
import 'package:foody_app/view/meat/meatViewAll.dart';
import 'package:foody_app/view/meat/meatViewOne.dart';
import 'package:foody_app/widget/app_bar.dart';

class MeatViewAllParticipants extends StatefulWidget {
  int meatId;

  MeatViewAllParticipants(this.meatId, {Key key}) : super(key: key);

  @override
  _MeatViewAllParticipantsState createState() =>
      _MeatViewAllParticipantsState(meatId);
}

class _MeatViewAllParticipantsState extends State<MeatViewAllParticipants> {
  int meatId;

  _MeatViewAllParticipantsState(this.meatId);

  Future<List<MeatParticipantModel>> futureMeatParticipants;

  @override
  void didChangeDependencies() {
    futureMeatParticipants = MeatHTTPService.readAllMeatParticipants(meatId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'All Participants',
          style: TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<MeatParticipantModel>>(
        future: futureMeatParticipants,
        builder: (context, AsyncSnapshot<List<MeatParticipantModel>> snapshot) {
          if (snapshot.hasData) {
            List<MeatParticipantModel> organisers = snapshot.data
                .where((MeatParticipantModel participant) =>
                    participant.role == "organiser")
                .toList();
            List<MeatParticipantModel> participants = snapshot.data
                .where((MeatParticipantModel participant) =>
                    participant.role == "participant")
                .toList();
            return Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Organiser",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ACCENT_COLOR,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 44,
                            maxHeight: 44),
                        child: Container(
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.contain,
                                    image: new NetworkImage(
                                        '${organisers[0].imageUrl}'))))),
                    title: Text('${organisers[0].username}'),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MeatViewAll()),
                          );
                        },
                        icon: Icon(Icons.chevron_right)),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Participants",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ACCENT_COLOR,
                      ),
                    ),
                  ),
                  Expanded(
                    child: (participants.length > 0)
                        ? ListView.builder(
                            itemCount: participants.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new ListTile(
                                leading: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minWidth: 44,
                                        minHeight: 44,
                                        maxWidth: 44,
                                        maxHeight: 44),
                                    child: Container(
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.contain,
                                                image: new NetworkImage(
                                                    '${participants[index].imageUrl}'))))),
                                title: Text('${participants[index].username}'),
                                trailing: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MeatViewAll()),
                                      );
                                    },
                                    icon: Icon(Icons.chevron_right)),
                              );
                            })
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 50, horizontal: 30),
                              child: Text(
                                "This meat does not have any participants yet",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                  ),
                ]);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
