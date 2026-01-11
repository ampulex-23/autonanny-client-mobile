import 'base_models/base_request.dart';

class LoginRequest implements NannyBaseRequest {
  LoginRequest({
    required this.login,
    required this.password,
    required this.fbid,
  });

  final String login;
  final String password;
  final String fbid;

  @override
  Map<String, dynamic> toJson() => {
    'login': login,
    'password': password,
    'fbid': fbid,
  };

  LoginRequest.fromJson(Map<String, dynamic> json) 
    : login = json['login'], 
      password = json['password'],
      fbid = json['fbid'];
}