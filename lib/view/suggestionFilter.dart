import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:foody_app/model/location_dto.dart';
import 'package:foody_app/model/preference_model.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/services/preferenceHTTPService.dart';
import 'package:google_maps_webservice/places.dart';

class SuggestionFilter extends StatefulWidget {
  SuggestionFilter({Key key}) : super(key: key);

  @override
  _SuggestionFilterState createState() => _SuggestionFilterState();
}

class _SuggestionFilterState extends State<SuggestionFilter> {
  Future<List<PreferenceModel>> futurePreferences;
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: AppConstants.GOOGLE_API_KEY);
  final TextEditingController locationCtl = TextEditingController();
  LocationDTO locationDTO = new LocationDTO();
  List<PreferenceModel> selectedPreferences = [];

  @override
  void didChangeDependencies() {
    futurePreferences = PreferenceHTTPService.getPreferences();
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
          'Suggestion Filter',
          style: TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<PreferenceModel>>(
        future: futurePreferences,
        builder: (context, AsyncSnapshot<List<PreferenceModel>> snapshot) {
          if (snapshot.hasData) {
            List<PreferenceModel> preferencesList = snapshot.data;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Search Around...",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ACCENT_COLOR,
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Location',
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
                    onTap: () async {
                      Prediction p = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: AppConstants.GOOGLE_API_KEY,
                          mode: Mode.fullscreen,
                          language: "en",
                          components: [new Component(Component.country, "my")]);
                      if (p != null) {
                        PlacesDetailsResponse detail =
                            await _places.getDetailsByPlaceId(p.placeId);
                        double lat = detail.result.geometry.location.lat;
                        double lng = detail.result.geometry.location.lng;
                        String name = detail.result.name;
                        String address = detail.result.formattedAddress;

                        locationCtl.text = name;
                        setState(() {
                          locationDTO = new LocationDTO(
                              latitude: lat,
                              longitude: lng,
                              locationName: name,
                              locationAddress: address);
                        });
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Preferences",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ACCENT_COLOR,
                      ),
                    ),
                  ),
                  Wrap(
                    children: preferencesList
                        .map((preference) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ChoiceChip(
                                selected:
                                    selectedPreferences.contains(preference),
                                selectedColor: AppColors.PRIMARY_COLOR,
                                label: Text(
                                  preference.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onSelected: (isBeenSelected) {
                                  if (isBeenSelected) {
                                    setState(() {
                                      selectedPreferences.add(preference);
                                    });
                                  } else {
                                    setState(() {
                                      selectedPreferences.remove(preference);
                                    });
                                  }
                                },
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            throw snapshot.error;
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.filter_alt,
                  color: Colors.white,
                ),
              ),
              Text(
                "Filter",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.PRIMARY_COLOR),
          ),
          onPressed: () {
            print("let's filter!");
            List<int> preferenceIds =
                selectedPreferences.map((e) => e.id).toList();
            print("preferences: " + preferenceIds.toString());
            print(locationDTO.toJson());
            Navigator.pop(context,
                {"preferences": selectedPreferences, "location": locationDTO});
          },
        ),
      ),
    );
  }
}
