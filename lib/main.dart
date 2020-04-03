import 'package:flutter/material.dart';
import './DataClasses/DataClasses.dart';
import './Dependencies/drawer.dart';
import './Dependencies/fetch.dart';
import './Dependencies/send.dart';
import './Dependencies/card.dart';
import './Dependencies/user.dart';
import './Dependencies/map.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: Greet(),
    );
  }
}

class MyApp extends StatefulWidget {
  final String uri;
  final String port;
  final User user;

  MyApp({
    this.uri,
    this.port,
    this.user,
  });

  @override
  _MyAppState createState() => _MyAppState(
        uri: uri,
        port: port,
        user: user,
      );
}

class _MyAppState extends State<MyApp> {
  final String uri;
  final String port;
  final User user;

  _MyAppState({
    this.uri,
    this.port,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Corona Tracker"),
        ),
        drawer: MainDrawer(
          uri: uri,
          port: port,
          user: user,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("Get List"),
                onPressed: () {
                  return Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Fetch(
                        uri: uri,
                        port: port,
                      ),
                    ),
                  );
                },
              ),
              RaisedButton(
                child: Text("Send"),
                onPressed: () {
                  print("Pressed");
                  return Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Send(
                        uri: uri,
                        port: port,
                      ),
                    ),
                  );
                },
              ),
              RaisedButton(
                child: Text("Map"),
                onPressed: () {
                  print("Pressed");
                  return Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Map(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Greet extends StatefulWidget {
  @override
  _GreetState createState() => _GreetState();
}

class _GreetState extends State<Greet> {
  var uriCont = TextEditingController();
  var portCont = TextEditingController();

  @override
  void dispose() {
    uriCont.dispose();
    portCont.dispose();
    super.dispose();
  }

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
                    decoration: InputDecoration(labelText: "Enter URI"),
                    controller: uriCont,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Enter Port"),
                    controller: portCont,
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
                      print(uriCont.text);
                      print(portCont.text);
                      if (uriCont.text != "" && portCont.text != "")
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => UserAuth(
                              uri: uriCont.text,
                              port: portCont.text,
                            ),
                          ),
                        );
                      else
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MaterialApp(
                              title: "Back",
                              home: SafeArea(
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
                          ),
                        );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
