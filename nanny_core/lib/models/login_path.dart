import 'package:flutter/material.dart';
import 'package:nanny_core/nanny_core.dart';

class LoginPath {
  LoginPath({
    required this.userType,
    required this.path
  });
  
  final UserType userType;
  final Widget path;
}