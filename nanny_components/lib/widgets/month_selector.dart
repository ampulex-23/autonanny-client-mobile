import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class MonthSelector extends StatefulWidget {
  final void Function(int month) onMonthChanged;
  
  const MonthSelector({
    super.key,
    required this.onMonthChanged,
  });

  @override
  State<MonthSelector> createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  late DateTime selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = _formatDate(DateTime.now());
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Flexible(
          flex: 1,
          child: SizedBox(
            width: 80,
            child: ElevatedButton(
              style: NannyButtonStyles.transparent,

              onPressed: () => changeMonth(-1), 
              child: const Icon(Icons.arrow_back_ios_new_rounded)
            ),
          )
        ),
        Flexible(
          flex: 3,
          child: Text(
            DateFormat(DateFormat.MONTH).format(selectedMonth),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            width: 80,
            child: ElevatedButton(
              style: NannyButtonStyles.transparent,

              onPressed: () => changeMonth(1), 
              child: const Icon(Icons.arrow_forward_ios_rounded)
            ),
          )
        ),

      ],
    );
  }

  void changeMonth(int increment) => setState(() {
    selectedMonth = selectedMonth.copyWith(month: selectedMonth.month + increment);
    widget.onMonthChanged(selectedMonth.month);
  });

  DateTime _formatDate(DateTime date) => DateTime(date.year, date.month, date.day);
}