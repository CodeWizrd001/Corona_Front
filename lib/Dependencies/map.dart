import 'package:corona_front/Dependencies/unimplemented.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../DataClasses/DataClasses.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Map extends StatefulWidget {
  final String uri;
  final String port;

  Map({
    this.uri,
    this.port,
  });

  @override
  _MapState createState() => _MapState(
        uri: uri,
        port: port,
      );
}

class _MapState extends State<Map> {
  MapController map = MapController();
  final String uri;
  final String port;

  _MapState({
    this.uri,
    this.port,
  });

  Future<CountryList> fetchCountryList() async {
    print("URI Map CountryList : $uri:$port/respond");
    http.Response response;
    try {
      response = await http.get(Uri.http("$uri:$port", "/countries/list"));
    } catch (e) {
      print("CountryList $e");
      return Future<CountryList>(null);
    }
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return CountryList.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  List<String> countryList = [
    'USA',
    'Italy',
    'Spain',
    'Germany',
    'France',
    'UK',
    'Iran',
    'Turkey',
    'Netherlands',
    'Belgium',
    'Switzerland',
    'Canada',
    'Portugal',
    'Brazil',
    'Austria',
    'Israel',
    'Sweden',
    'Norway',
    'Australia',
    'Ireland',
    'Russia',
    'Czechia',
    'Poland',
    'Chile',
    'S. Korea',
    'India',
    'Ecuador',
    'Romania',
    'Philippines',
    'Pakistan',
    'Denmark',
    'Japan',
    'Malaysia',
    'Luxembourg',
    'Saudi Arabia',
    'Indonesia',
    'Panama',
    'Finland',
    'Greece',
    'Serbia',
    'Dominican Republic',
    'South Africa',
    'Thailand',
    'China',
    'UAE',
    'Colombia',
    'Qatar',
    'Ukraine',
    'Mexico',
    'Argentina',
    'Algeria',
    'Estonia',
    'Iceland',
    'Croatia',
    'Slovenia',
    'Singapore',
    'New Zealand',
    'Morocco',
    'Lithuania',
    'Peru',
    'Egypt',
    'Armenia',
    'Moldova',
    'Hong Kong',
    'Hungary',
    'Bosnia and Herzegovina',
    'Iraq',
    'Latvia',
    'Tunisia',
    'Cameroon',
    'Kazakhstan',
    'Azerbaijan',
    'Bulgaria',
    'Slovakia',
    'Lebanon',
    'North Macedonia',
    'Andorra',
    'Costa Rica',
    'Kuwait',
    'Cyprus',
    'Belarus',
    'Afghanistan',
    'Taiwan',
    'Uruguay',
    'Réunion',
    'Uzbekistan',
    'Cuba',
    'Bahrain',
    'Jordan',
    'Channel Islands',
    'Honduras',
    'Burkina Faso',
    'Oman',
    'Ivory Coast',
    'Albania',
    'Mauritius',
    'Malta',
    'Palestine',
    'San Marino',
    'Montenegro',
    'Nigeria',
    'Ghana',
    'Vietnam',
    'Senegal',
    'Bolivia',
    'Kyrgyzstan',
    'Niger',
    'Georgia',
    'DRC',
    'Sri Lanka',
    'Isle of Man',
    'Mayotte',
    'Kenya',
    'Martinique',
    'Guinea',
    'Guadeloupe',
    'Rwanda',
    'Venezuela',
    'Trinidad and Tobago',
    'Paraguay',
    'Diamond Princess',
    'Faeroe Islands',
    'Liechtenstein',
    'Madagascar',
    'Brunei ',
    'Cambodia',
    'Aruba',
    'Monaco',
    'El Salvador',
    'Barbados',
    'Bangladesh',
    'Uganda',
    'Gibraltar',
    'Jamaica',
    'Guatemala',
    'Djibouti',
    'French Polynesia',
    'French Guiana',
    'Mali',
    'Zambia',
    'Macao',
    'Ethiopia',
    'Cayman Islands',
    'Eritrea',
    'Bahamas',
    'Bermuda',
    'Togo',
    'Saint Martin',
    'Guyana',
    'Myanmar',
    'Haiti',
    'Gabon',
    'Congo',
    'Guinea-Bissau',
    'Libya',
    'Tanzania',
    'New Caledonia',
    'Sint Maarten',
    'Syria',
    'Equatorial Guinea',
    'Antigua and Barbuda',
    'Benin',
    'Dominica',
    'Namibia',
    'Saint Lucia',
    'Mongolia',
    'Fiji',
    'Grenada',
    'Laos',
    'Seychelles',
    'Suriname',
    'Mozambique',
    'Chad',
    'Saint Kitts and Nevis',
    'Eswatini',
    'Greenland',
    'Zimbabwe',
    'Nepal',
    'CAR',
    'MS Zaandam',
    'Vatican City',
    'Maldives',
    'Angola',
    'Sudan',
    'Liberia',
    'Cabo Verde',
    'St. Vincent Grenadines',
    'Somalia',
    'Montserrat',
    'Curaçao',
    'St. Barth',
    'Turks and Caicos',
    'Nicaragua',
    'Belize',
    'Malawi',
    'Sierra Leone',
    'Western Sahara',
    'Mauritania',
    'Bhutan',
    'Botswana',
    'Anguilla',
    'British Virgin Islands',
    'Burundi',
    'Caribbean Netherlands',
    'Gambia',
    'Falkland Islands',
    'Papua New Guinea',
    'Timor-Leste',
  ];

  List<LatLng> pointList = [
    LatLng(37.16, -101.378),
    LatLng(42.79, 11.97),
    LatLng(39.44, -2.61),
    LatLng(51.18, 9.79),
    LatLng(46.89, 2.02),
    LatLng(54.59, -2.87),
    LatLng(31.40, 54.56),
    LatLng(38.72, 34.15),
    LatLng(52.19, 5.44),
    LatLng(50.75, 4.6),
  ];

  List<Marker> mList = [];
  Future<CountryList> fcList;
  CountryList cList;
  Country tmp;
  double max;
  double min;
  double scale;

  Country searchCountry(name) {
    var x = cList.length;
    for (int i = 0; i < x; i += 1) {
      tmp = cList.list[i];
      if (tmp.cName == name) return tmp;
    }
    return null;
  }

  void clicked(context, x) {
    tmp = searchCountry(x);
    print(x);
    print(tmp);
    var cN = tmp.cName;
    var tC = tmp.tCases;
    var nC = tmp.nCases;
    var tD = tmp.tDeaths;
    var nD = tmp.nDeaths;
    var tR = tmp.tRec;
    var aC = tmp.aCases;
    var sC = tmp.sCrit;
    var cM = tmp.tCm;
    var dM = tmp.tDm;
    Alert(
      context: context,
      title: "$cN",
      desc: """Total Cases : \t$tC
New Cases : \t$nC 
Total Deaths : \t$tD
New Deaths : \t$nD 
Total Recovered : \t$tR 
Active Cases : $aC
Serious\Critical : \t$sC 
Cases/1M : \t\t$cM
Deaths/1M : \t\t$dM """,
      style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: false,
      ),
    ).show();
  }

  Color getColor(Country x) {
    if (x == null) return Colors.white;
    var z = x.tCm;
    var y = z * scale;
    print(y) ;
    var a = y.floor() ;
    return Color.fromRGBO(a, a, 240, 0.9) ;
    // return Colors.blue.withBlue(y.floor()) ;
  }

  void generatemList(context, data) {
    var x = pointList.length;
    int i;
    cList = data;
    min = cList.min;
    max = cList.max;
    scale = cList.scale;
    for (i = 0; i < x; i += 1) {
      var y = countryList[i];
      var z = pointList[i];
      Country tmp = searchCountry(y);
      var temp = Marker(
        width: 20.0,
        height: 20.0,
        point: z,
        builder: (ctx) => Container(
          child: RaisedButton(
            color: getColor(tmp),
            child: Text(y),
            onPressed: () {
              print("Button Pressed $i");
              clicked(context, y);
            },
          ),
        ),
      );
      mList.add(temp);
    }
  }

  @override
  void initState() {
    super.initState();
    fcList = fetchCountryList();
    print("initState");
    print(cList);
  }

  @override
  Widget build(BuildContext context) {
    print("Return Map");
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: FutureBuilder<CountryList>(
              future: fcList,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.error !=
                        "NoSuchMethodError: The method 'call' was called on null.") {
                  if (snapshot.data.toString() != null) {
                    generatemList(context, snapshot.data);
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: FlutterMap(
                              mapController: map,
                              options: MapOptions(
                                center: LatLng(0, 11.543808),
                                zoom: 1.25,
                                maxZoom: 5,
                                minZoom: 1.25,
                                swPanBoundary: LatLng(-75, -100.5),
                                nePanBoundary: LatLng(75, 100.5),
                              ),
                              layers: [
                                TileLayerOptions(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c']),
                                MarkerLayerOptions(
                                  markers: mList,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.black,
                    body: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: Center(
                                child: Text(
                                  "Loading...",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
