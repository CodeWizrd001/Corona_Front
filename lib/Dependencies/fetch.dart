import 'package:flutter/material.dart';
import '../DataClasses/DataClasses.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Fetch extends StatefulWidget {
  final String uri;
  final String port;

  Fetch({
    this.uri,
    this.port,
  });

  @override
  _FetchState createState() {
    print("URI Fetch : $uri");
    return _FetchState(
      uri: uri,
      port: port,
    );
  }
}

class _FetchState extends State<Fetch> {
  final String uri;
  final String port;
  _FetchState({
    this.uri,
    this.port,
  });

  Future<Country> v;
  Future<CountryList> t;
  List<ListTile> list = [
    ListTile(
      title: Text("Hello"),
    )
  ];

  int a = 0;

  @override
  void initState() {
    super.initState();
    t = fetchCountryList();
  }

  void buildList(CountryList t) {
    list = [
      ListTile(
        title: Text(
          "List Of Countries",
          style: TextStyle(
            color: Colors.teal,
            fontSize: 25,
          ),
        ),
      ),
    ];
    var x = t.length;
    print("BuildList Called $x");
    for (int i = 0; i < x; i += 1) {
      var tmp = t.list[i];
      var cN = tmp.cName;
      var tC = tmp.tCases;
      var nC = tmp.nCases ;
      var tD = tmp.tDeaths ;
      var nD = tmp.nDeaths ;
      var tR = tmp.tRec ;
      var aC = tmp.aCases ;
      var sC = tmp.sCrit ;
      var cM = tmp.tCm ;
      var dM = tmp.tDm ;
      var temp = ListTile(
        title: Text(
          """
$cN 
Total Cases : \t$tC
New Cases : \t$nC 
Total Deaths : \t$tD
New Deaths : \t$nD 
Total Recovered : \t$tR 
Active Cases : $aC
Serious\Critical : \t$sC 
Cases/1M : \t\t$cM
Deaths/1M : \t\t$dM 
          """,
          style: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
          ),
        ),
      );
      list.add(temp);
    }
  }

  Future<Country> fetchCountry() async {
    print("URI Country : $uri:$port/respond_2");
    http.Response response;
    try {
      response = await http.get(Uri.http("$uri:$port", "/countries/list"));
    } catch (e) {
      print("Country $e");
      return Future<Country>(null);
    }

    if (response.statusCode == 200) {
      return Country.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Country');
    }
  }

  Future<CountryList> fetchCountryList() async {
    print("URI CountryList : $uri:$port/respond");
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
      throw Exception('Failed to load List');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: FutureBuilder<CountryList>(
            future: t,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.error !=
                      "NoSuchMethodError: The method 'call' was called on null.") {
                if (snapshot.data.toString() != null) {
                  buildList(snapshot.data);
                  return Scaffold(
                    backgroundColor: Colors.white70,
                    body: ListView(
                      children: list,
                    ),
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
    );
  }
}
