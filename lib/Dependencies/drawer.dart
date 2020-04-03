import 'package:flutter/material.dart';
import '../DataClasses/DataClasses.dart';
import './unimplemented.dart';
import './fetch.dart';
import './send.dart';

class MainDrawer extends StatefulWidget {
  final String uri;
  final String port;
  final User user;

  final List<String> cList = [
    "Countries List",
    "Search",
  ];

  final List<IconData> icList = [
    Icons.list,
    Icons.search,
  ];

  MainDrawer({
    this.user,
    this.uri,
    this.port,
  });

  @override
  _MainDrawerState createState() => _MainDrawerState(
        uName: user.uname,
        uId: user.umail,
        uIn: user.uin,
        cList: cList,
        icList: icList,
        uri: uri,
        port: port,
      );
}

class _MainDrawerState extends State<MainDrawer> {
  final String uName;
  final String uId;
  final String uIn;
  final String uri;
  final String port;
  final List<String> cList;
  final List<IconData> icList;

  static BuildContext bc;

  static void pres() {
    print("Pressed");
  }

  var tScaf = SafeArea(
    child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: pres, label: Text("HelloWorld"))),
  );

  List<Widget> clList = [];
  List<ListTile> iList = [
    ListTile(
      title: Text('Club 1'),
      trailing: Icon(Icons.build),
      onTap: () => Navigator.of(bc).push(
          MaterialPageRoute(builder: (BuildContext context) => Scaffold())),
    ),
    ListTile(
      title: Text('Club 2'),
      trailing: Icon(Icons.airplanemode_active),
      onTap: () => Navigator.of(bc).push(
          MaterialPageRoute(builder: (BuildContext context) => Scaffold())),
    ),
  ];

  _MainDrawerState({
    this.uName,
    this.uId,
    this.uIn,
    this.cList,
    this.icList,
    this.uri,
    this.port,
  });

  fUn() => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => Fetch(
            uri: uri,
            port: port,
          ),
        ),
      );

  fuN() => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => Send(
            uri: uri,
            port: port,
          ),
        ),
      );

  void createList(context) {
    var xX = cList[0] ;
    var yY = cList[1] ;
    print("Drawer $uri:$port");
    clList = [
      UserAccountsDrawerHeader(
        accountName: Text('$uName'),
        accountEmail: Text('$uId'),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.black26,
          child: Text('$uIn'),
        ),
      ),
      ListTile(
        title: Text("$xX"),
        trailing: Icon(icList[0]),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Fetch(
              uri: uri,
              port: port,
            ),
          ),
        ),
      ),
      ListTile(
        title: Text("$yY"),
        trailing: Icon(icList[1]),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Send(
              uri: uri,
              port: port,
            ),
          ),
        ),
      )
    ];
    /*
    ListTile temp;
    int x;
    int y;
    x = cList.length;
    y = icList.length;
    String tS;
    IconData tI;
    for (int i = 0; i < x; i += 1) {
      tS = cList[i];
      tI = icList[i];
      temp = ListTile(
        title: Text("$tS"),
        trailing: Icon(tI),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Unimplemented(),
          ),
        ),
      );
      clList.add(temp);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    createList(context);
    return Drawer(
      child: ListView(
        children: clList,
      ),
    );
  }
}
