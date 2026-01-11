import 'package:flutter/material.dart';
import 'package:nanny_components/widgets/net_image.dart';

class ProfileImage extends StatelessWidget {
  final String url;
  final double radius;
  final VoidCallback? onTap;
  final EdgeInsets? padding;

  const ProfileImage({
    super.key,
    this.padding,
    required this.url,
    required this.radius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: radius,
        height: radius,
        child: IconButton(
            padding: padding,
            onPressed: onTap,
            splashRadius: radius * .5,
            icon: ClipOval(
                child: url.isNotEmpty
                    ? NetImage(
                        url: url,
                        placeholderPath:
                            "packages/nanny_components/assets/images/no_user.jpg")
                    : Container(
                        color: const Color(0xFFE0E0E0),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.person,
                          color: const Color(0xFF9E9E9E),
                          size: radius * 0.6,
                        ),
                      ))));
  }
}
