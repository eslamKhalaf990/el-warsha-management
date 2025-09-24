class User {
  String? _username;
  String? _email;
  String? _password;

  String get username => _username ?? "-";

  String get email => _email ?? "-";

  String get password => _password ?? "-";

  set username(String value) {
    _username = value;
  }

  set password(String value) {
    _password = value;
  }

  set email(String value) {
    _email = value;
  }
}