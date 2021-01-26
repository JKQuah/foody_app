import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:foody_app/model/locationDTO.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/resource/app_constants.dart';
import 'package:foody_app/view/foodSuggestionResult.dart';
import 'package:foody_app/widget/app_bar.dart';
import 'package:google_maps_webservice/places.dart';

class FoodSuggestionView extends StatefulWidget {
  FoodSuggestionView({Key key}) : super(key: key);

  @override
  _FoodSuggestionViewState createState() => _FoodSuggestionViewState();
}

class _FoodSuggestionViewState extends State<FoodSuggestionView> {
  GoogleMapsPlaces _places =
  GoogleMapsPlaces(apiKey: AppConstants.googleApiKey);
  final TextEditingController locationCtl = TextEditingController();
  LocationDTO locationDTO = new LocationDTO();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
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
                    apiKey: AppConstants.googleApiKey,
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
            Expanded(
              child: Container(

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  print(locationDTO.toJson());
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SuggestionResultView(location: locationDTO)),
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
