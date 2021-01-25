import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/chat/chats_page.dart';
import 'package:foody_app/model/location_dto.dart';
import 'package:foody_app/model/meat_model.dart';
import 'package:foody_app/model/preference_model.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/utils/convertUtils.dart';
import 'package:foody_app/view/meat/meatCreate.dart';
import 'package:foody_app/view/meat/meatViewOne.dart';
import 'package:foody_app/widget/app_bar.dart';
import 'package:foody_app/services/meatHTTPService.dart';

import '../suggestionFilter.dart';
import 'meatUpdate.dart';

class MeatViewAll extends StatefulWidget {
  MeatViewAll({Key key}) : super(key: key);

  @override
  _MeatViewAllState createState() => _MeatViewAllState();
}

class _MeatViewAllState extends State<MeatViewAll> {
  Future<List<MeatModel>> upcomingMeatMeatModels;
  Future<List<MeatModel>> futureMeatMeatModels;
  List<PreferenceModel> selectedPreferences;
  LocationDTO selectedLocation;

  @override
  void didChangeDependencies() {
    upcomingMeatMeatModels = MeatHTTPService.getUpcomingMeats();
    futureMeatMeatModels = MeatHTTPService.getExploreMeats(null, null);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  'assets/app_logo.png',
                  height: 35,
                ),
              ),
              Text(
                "Meat & Eat",
                style: TextStyle(
                  fontFamily: 'Nexa',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.TEXT_COLOR,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(
                  CupertinoIcons.chat_bubble_2,
                  size: 30,
                ),
                color: AppColors.PRIMARY_COLOR,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      //return ChatRoomView();
                      return ChatsPage();
                    },
                  ));
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List<dynamic>>(
            future: Future.wait([upcomingMeatMeatModels, futureMeatMeatModels]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                List<MeatModel> upcomingMeatMeatModels =
                    snapshot.data[0] as List<MeatModel>;
                List<MeatModel> exploringMeats =
                    snapshot.data[1] as List<MeatModel>;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Upcoming",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ACCENT_COLOR,
                              ),
                            ),
                          ),
                          RaisedButton(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.create,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Create",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MeatCreate()),
                              );
                            },
                            color: AppColors.PRIMARY_COLOR,
                          )
                        ],
                      ),
                      Container(
                        height: 360.0,
                        child: (upcomingMeatMeatModels.length > 0)
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: upcomingMeatMeatModels.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return new UpcomingMeatCard(
                                      upcomingMeatMeatModels[index]);
                                })
                            : Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 50, horizontal: 30),
                                  child: Text(
                                    "You have no upcoming meats. Create or join one now!",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Explore",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ACCENT_COLOR,
                              ),
                            ),
                          ),
                          RaisedButton(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.filter_alt,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Filter",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              final Map<String, dynamic> filterResult =
                                  await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => SuggestionFilter()),
                              );
                              List<PreferenceModel> selectedPreferences =
                                  filterResult["preferences"]
                                      as List<PreferenceModel>;
                              LocationDTO selectedLocation =
                                  filterResult["location"] as LocationDTO;
                              setState(() {
                                this.selectedPreferences = selectedPreferences;
                                this.selectedLocation = selectedLocation;
                                futureMeatMeatModels =
                                    MeatHTTPService.getExploreMeats(
                                        selectedLocation, selectedPreferences);
                              });
                            },
                            color: AppColors.PRIMARY_COLOR,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Filtering...",
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic),
                            ),
                            if (hasPrefFilter())
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Preference: " +
                                      this
                                          .selectedPreferences
                                          .map((e) => e.name)
                                          .join(", "),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            if (hasLocFilter())
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Nearby: " +
                                      this.selectedLocation.locationName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                          ],
                        ),
                      ),
                      ...exploringMeats.map((e) => new ExploreMeatCard(e))
                    ]);
              } else if (snapshot.hasError) {
                throw snapshot.error;
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  bool hasPrefFilter() {
    bool isNull = this.selectedPreferences == null;
    if (isNull) return false;
    bool hasElement = this.selectedPreferences.length > 0;
    return hasElement;
  }

  bool hasLocFilter() {
    bool isNull = this.selectedLocation == null;
    if (isNull) return false;
    bool hasLoc = this.selectedLocation.latitude != null && this.selectedLocation.longitude != null;
    return hasLoc;
  }
}

class UpcomingMeatCard extends StatelessWidget {
  MeatModel meatModel;

  UpcomingMeatCard(this.meatModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(1),
                    topRight: Radius.circular(1),
                    bottomLeft: Radius.circular(1),
                    bottomRight: Radius.circular(1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Image.network(
                meatModel.imageUrl,
                fit: BoxFit.fitWidth,
                height: 260,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
              child: Text(
                meatModel.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.ACCENT_COLOR,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                ConvertUtils.formDateTimeToStr(meatModel.startTime),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeatViewOne(meatModel.id)),
          );
        },
      ),
    );
  }
}

class ExploreMeatCard extends StatelessWidget {
  MeatModel meatModel;

  ExploreMeatCard(this.meatModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            meatModel.imageUrl,
            fit: BoxFit.fitWidth,
            height: 260,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Text(
              meatModel.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.ACCENT_COLOR,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Text(
              "${meatModel.distanceInKm} km away",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MeatViewOne(meatModel.id)),
        );
      },
    );
  }
}
