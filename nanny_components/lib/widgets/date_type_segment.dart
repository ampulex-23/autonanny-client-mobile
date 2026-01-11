import 'package:flutter/material.dart';
import 'package:nanny_components/styles/nanny_theme.dart';
import 'package:nanny_core/constants.dart';

class DateTypeSegment extends StatefulWidget {
  final void Function(DateType type) onChanged;
  
  const DateTypeSegment({
    super.key,
    required this.onChanged,
  });

  @override
  State<DateTypeSegment> createState() => _DateTypeSegmentState();
}

class _DateTypeSegmentState extends State<DateTypeSegment> {
  DateType selectedDateType = DateType.week;
  
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<DateType>(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: NannyTheme.lightGreen,
        disabledForegroundColor: NannyTheme.onSecondary
      ),
      showSelectedIcon: false,
      segments: DateType.values.map(
        (e) => ButtonSegment<DateType>(
          value: e,
          label: Text(e.name),
          enabled: e != selectedDateType
        )
      ).toList(), 
      selected: { selectedDateType },
      onSelectionChanged: (dateType) {
        setState(() => selectedDateType = dateType.first);
        widget.onChanged(dateType.first);
      },
    );
  }
}