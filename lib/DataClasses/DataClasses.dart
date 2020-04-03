class Country {
  final String cName;
  final int tCases;
  final int nCases;
  final int tDeaths;
  final int nDeaths;
  final int tRec;
  final int aCases;
  final int sCrit;
  final double tCm;
  final double tDm;

  Country({
    this.cName,
    this.tCases,
    this.nCases,
    this.tDeaths,
    this.nDeaths,
    this.tRec,
    this.aCases,
    this.sCrit,
    this.tCm,
    this.tDm,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      cName: json['CountryName'],
      tCases: json['TotalCases'] as int ,
      nCases: json['NewCases'] as int ,
      tDeaths: json['TotalDeaths'] as int ,
      nDeaths: json['NewDeaths'] as int ,
      tRec: json['TotalRecovered'] as int ,
      aCases: json['ActiveCases'] as int ,
      sCrit: json['SeriousCritical'] as int ,
      tCm: json['CasesPM'] as double ,
      tDm: json['DeathPM'] as double,
    );
  }
}

class Bool {
  final bool acc;

  Bool({this.acc});

  factory Bool.fromJson(Map<String, dynamic> json) {
    var x = json['status'];
    if (x == "done")
      return Bool(
        acc: true,
      );
    else
      return Bool(
        acc: false,
      );
  }
}

class User {
  final String uname;
  final String umail;
  final String uid;
  final String uin;
  final bool avail;

  User({
    this.uname,
    this.umail,
    this.uid,
    this.uin,
    this.avail,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uname: json['Name'],
      umail: json['Age'],
      uid: json['uid'],
      avail: true,
    );
  }
}

class CountryList {
  final List<Country> list;
  final int len;

  CountryList({this.list, this.len});

  int get length {
    print("Entered Get");
    return len;
  }

  factory CountryList.fromJson(Map<String, dynamic> json) {
    var t = json['data'];
    int x = t.length;
    List<Country> z = [];
    print("List Length $x");
    for (int i = 0; i < x; i += 1) {
      var tmp = t[i];
      var temp = Country.fromJson(tmp);
      z.add(temp);
    }
    return CountryList(list: z, len: x);
  }
}
