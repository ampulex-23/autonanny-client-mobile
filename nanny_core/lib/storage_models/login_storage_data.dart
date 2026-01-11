import 'base_storage.dart';

class LoginStorageData implements BaseStorage {
  LoginStorageData({
    required this.login,
    required this.password,
    // required this.haveSetPincode
  });

  @override
  Map<String, dynamic> toJson() => {
    'login': login,
    'password': password,
    // 'haveSetPincode': haveSetPincode,
  };

  LoginStorageData.fromJson(Map<String, dynamic> json) 
    : login = json['login'],
      password = json['password'];
      // haveSetPincode = json['haveSetPincode'];

  final String login;
  final String password;
  // final bool haveSetPincode;
  
}