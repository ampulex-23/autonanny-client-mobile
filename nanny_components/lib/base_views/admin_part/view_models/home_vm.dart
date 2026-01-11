import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class AdminHomeVM extends ViewModelBase {
  AdminHomeVM({
    required super.context, 
    required super.update,
    required this.regView,
  });

  final Widget regView;

  void navigateToProfile() => Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) => ProfileView(
      logoutView: WelcomeView(
        regView: regView, 
        loginPaths: NannyConsts.availablePaths,
      ),
    )),
  );
}