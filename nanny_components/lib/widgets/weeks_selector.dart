import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class WeeksSelector extends StatefulWidget {
  final void Function(NannyWeekday weekday) onChanged;
  final List<NannyWeekday> selectedWeekday;

  const WeeksSelector({
    super.key,
    required this.onChanged,
    required this.selectedWeekday,
  });

  @override
  State<WeeksSelector> createState() => _WeeksSelectorState();
}

class _WeeksSelectorState extends State<WeeksSelector> {
  @override
  Widget build(BuildContext context) {
    return AdaptBuilder(
      builder: (context, size) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: NannyWeekday.values
                .map(
                  (e) => SizedBox(
                    width: size.width * .12,
                    height: size.height * .08,
                    child: ElevatedButton(
                      style: (widget.selectedWeekday.contains(e)
                              ? NannyButtonStyles.defaultButtonStyle
                              : NannyButtonStyles.whiteButton)
                          .copyWith(
                        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                        elevation: const WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.6),
                          ),
                        ),
                      ),
                      onPressed: () => widget.onChanged(e),
                      child: Text(
                        e.shortName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: widget.selectedWeekday.contains(e)
                                ? NannyTheme.secondary
                                : const Color(0xFF2B2B2B),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
                .toList());
      },
    );
  }
}
