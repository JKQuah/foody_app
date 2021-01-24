import 'package:flutter/material.dart';
import 'package:foody_app/model/meat_model.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/utils/convertUtils.dart';
import 'package:foody_app/widget/app_bar.dart';
import 'package:foody_app/services/meatHTTPService.dart';

import 'meatCreate.dart';

class MeatViewAll extends StatefulWidget {
  MeatViewAll({Key key}) : super(key: key);

  @override
  _MeatViewAllState createState() => _MeatViewAllState();
}

class _MeatViewAllState extends State<MeatViewAll> {
  Future<List<MeatModel>> futureMeatMeatModels;

  @override
  void didChangeDependencies() {
    futureMeatMeatModels = MeatHTTPService.getExploreMeats();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: FoodyAppBar(),
        body: SingleChildScrollView(
          child: FutureBuilder<List<MeatModel>>(
            future: futureMeatMeatModels,
            builder: (context, AsyncSnapshot<List<MeatModel>> snapshot) {
              if (snapshot.hasData) {
                List<MeatModel> exploringMeats = snapshot.data;
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
                            onPressed: () {},
                            color: AppColors.PRIMARY_COLOR,
                          )
                        ],
                      ),
                      Container(
                        height: 360.0,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: exploringMeats.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new UpcomingMeatCard(
                                  exploringMeats[index]);
                            }),
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
                            onPressed: () {},
                            color: AppColors.PRIMARY_COLOR,
                          )
                        ],
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
            Image.network(
              meatModel.imageUrl,
              fit: BoxFit.fitWidth,
              height: 260,
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
          print("tap explore");
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
        print("tap explore");
      },
    );
  }
}
