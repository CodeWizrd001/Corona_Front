import 'dart:convert';

import 'package:flutter/material.dart';
import '../DataClasses/DataClasses.dart';
import 'package:http/http.dart' as http;

class Send extends StatefulWidget {
  final String uri;
  final String port;

  Send({
    this.uri,
    this.port,
  });

  @override
  _SendState createState() => _SendState(uri: uri, port: port);
}

class _SendState extends State<Send> {
  final String uri;
  final String port;

  var nameCont = TextEditingController();
  var ageCont = TextEditingController();

  _SendState({
    this.uri,
    this.port,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Name"),
                    controller: nameCont,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    child: Text("Enter"),
                    onPressed: () {
                      print(nameCont.text);
                      print(ageCont.text);
                      if (nameCont.text != "") {
                        var data = Country(
                          cName: nameCont.text,
                        );
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SendData(
                              uri: uri,
                              port: port,
                              data: data,
                            ),
                          ),
                        );
                      } else
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SafeArea(
                              child: Scaffold(
                                backgroundColor: Colors.black,
                                body: Center(
                                  child: Text(
                                    "Enter All Info",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SendData extends StatefulWidget {
  final String uri;
  final String port;
  final Country data;

  SendData({
    this.uri,
    this.port,
    this.data,
  });

  @override
  _SendDataState createState() =>
      _SendDataState(uri: uri, port: port, data: data);
}

class _SendDataState extends State<SendData> {
  final String uri;
  final String port;
  final Country data;

  _SendDataState({
    this.uri,
    this.port,
    this.data,
  });

  Future<CountryList> t;
  List<ListTile> list = [];

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
    if (x == 0) {
      list.add(ListTile(
        title: Text(
          "None",
          style: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
          ),
        ),
      ));
    }
    print("BuildList Called $x");
    for (int i = 0; i < x; i += 1) {
      var tmp = t.list[i];
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
      var temp = ListTile(
        title: Text(
          """
$cN 
Total Cases : $tC
New Cases : $nC 
Total Deaths : $tD
New Deaths : $nD 
Total Recovered : $tR 
Active Cases : $aC
Serious/Critical : $sC 
Cases/1M : $cM
Deaths/1M : $dM 
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

  Future<CountryList> sendData() async {
    print("Sending Request $uri:$port");
    final http.Response response = await http.post(
      Uri.http("$uri:$port", "/countries/get"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'cName': data.cName,
      }),
    );
    if (response.statusCode == 200) {
      return CountryList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    t = sendData();
    return SafeArea(
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
    );
  }
}
