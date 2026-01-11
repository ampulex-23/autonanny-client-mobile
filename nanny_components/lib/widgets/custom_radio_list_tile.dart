import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';

class CustomRadioListTile extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onTap;

  const CustomRadioListTile({
    Key? key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(splashColor: Colors.transparent),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: NannyTheme.secondary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 11,
              color: const Color(0xFF021C3B).withOpacity(.12),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0,
          minTileHeight: 0,
          minVerticalPadding: 0,
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: NannyTheme.primary, width: 2),
            ),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.transparent,
              child: isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 1, top: 1),
                      child: SvgPicture.asset(
                          'packages/nanny_components/assets/images/check.svg',
                          height: 12.8,
                          width: 12.8,
                          color: NannyTheme.primary),
                    )
                  : null,
            ),
          ),
          title: Text(
            title,
            style: isSelected
                ? Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w600)
                : Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
