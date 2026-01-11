import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/views/pages/profile.dart';

class ProfileIconButton extends StatelessWidget {
  final Widget logoutView;
  
  const ProfileIconButton({
    super.key,
    required this.logoutView,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => ProfileView(
            logoutView: logoutView
          ),
        ),
      ), 
      icon: const Icon(Icons.account_circle),
      iconSize: 25,
    );
  }
}