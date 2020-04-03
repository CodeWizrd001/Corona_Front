import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../DataClasses/DataClasses.dart';
import 'dart:convert';
import '../main.dart';

class UserAuth extends StatefulWidget {
  final String uri;
  final String port;

  UserAuth({
    this.uri,
    this.port,
  });

  @override
  _UserAuthState createState() => _UserAuthState(
        uri: uri,
        port: port,
      );
}

class _UserAuthState extends State<UserAuth> {
  final String uri;
  final String port;

  _UserAuthState({
    this.uri,
    this.port,
  });

  Future<Bool> log;

  Future<Bool> init() async {
    var sRes = await http.get(Uri.http("$uri:$port", "/countries/init"));
    var uRes = await http.get(Uri.http("$uri:$port", "/user/init"));
    if (uRes.statusCode == 200) {
      return Bool.fromJson(json.decode(sRes.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    log = init();
    return SafeArea(
      child: FutureBuilder<Bool>(
        future: log,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Auth(
              uri: uri,
              port: port,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class Auth extends StatefulWidget {
  final String uri;
  final String port;

  Auth({
    this.uri,
    this.port,
  });

  @override
  _AuthState createState() => _AuthState(
        uri: uri,
        port: port,
      );
}

class _AuthState extends State<Auth> {
  final String uri;
  final String port;

  _AuthState({
    this.uri,
    this.port,
  });

  var u = User(
    uname: "Corona",
    umail: "corona@virus",
    uin: "CV",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyApp(
        uri: uri,
        port: port,
        user: u,
      ),
    );
  }
}
