class User {
  final String userid;
  final String name;
  final String pnumber;
  final String email;
  final DateTime joinedon;
  User(
      {required this.userid,
      required this.name,
      required this.pnumber,
      required this.email,
      required this.joinedon});
  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'pnumber': pnumber,
      'email': email,
      'joined on': joinedon,
      'user id': userid,
    };
  }

  User fromJson(Map<String, dynamic> json) {
    return User(
        userid: json['userid'],
        name: json['name'],
        pnumber: json['pnumber'],
        email: json['email'],
        joinedon: json['joined on']);
  }
}
