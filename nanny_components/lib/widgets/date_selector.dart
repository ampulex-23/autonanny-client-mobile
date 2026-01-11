import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class DateSelector extends StatefulWidget {
  final void Function(DateTime date) onDateSelected;
  final bool showMonthSelector;

  const DateSelector({
    super.key,
    required this.onDateSelected,
    this.showMonthSelector = true,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  void initState() {
    super.initState();

    currentDate = DateTime.now();
    selectedDate = currentDate;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptBuilder(builder: (context, size) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showMonthSelector)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      style: NannyButtonStyles.transparent,
                      onPressed: () => changeWeek(false),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: NannyTheme.primary, size: 20),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        capitalize(
                            DateFormat(DateFormat.MONTH).format(currentDate)),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 17.6 / 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2B2B2B),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        currentDate.year.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          height: 16 / 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6A6A6A),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      style: NannyButtonStyles.transparent,
                      onPressed: () => changeWeek(true),
                      child: const Icon(Icons.arrow_forward_ios_rounded,
                          color: NannyTheme.primary, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getWeekdaysBtns(size, currentDate),
          ),
        ],
      );
    });
  }

  Widget weekdayBtn(Size size, DateTime date, bool isSelected) {
    return Container(
      width: size.width * .12,
      height: size.height * .08,
      decoration: BoxDecoration(
        boxShadow: [
          if (isSelected)
            BoxShadow(
                color: const Color(0xFF3028A8).withOpacity(.15),
                offset: const Offset(0, 3),
                blurRadius: 6,
                spreadRadius: -18)
        ],
      ),
      child: ElevatedButton(
        onPressed: () => selectDate(date),
        style: (isSelected
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              capitalize(DateFormat(DateFormat.ABBR_WEEKDAY).format(date)),
              style: TextStyle(
                  color: isSelected
                      ? NannyTheme.secondary
                      : NannyTheme.onSecondary,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            if (widget.showMonthSelector)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  date.day < 10 ? "0${date.day}" : date.day.toString(),
                  style: TextStyle(
                      color:
                          isSelected ? NannyTheme.secondary : Color(0xFF6D6D6D),
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void selectDate(DateTime date) => setState(() {
        selectedDate = date;
        widget.onDateSelected(date);
      });

  List<Widget> getWeekdaysBtns(Size size, DateTime date) {
    int daysAfterMonday = date.weekday - 1;
    DateTime start =
        DateTime(date.year, date.month, date.day - daysAfterMonday);
    List<Widget> btns = [];

    for (int i = 0; i < 7; i++) {
      DateTime weekdayDate = start.add(Duration(days: i));

      btns.add(weekdayBtn(size, weekdayDate,
          DateUtils.dateOnly(selectedDate) == DateUtils.dateOnly(weekdayDate)));
    }

    return btns;
  }

  String capitalize(String text) => text[0].toUpperCase() + text.substring(1);
  void changeWeek(bool add) => setState(
      () => currentDate = currentDate.add(Duration(days: add ? 7 : -7)));

  late DateTime selectedDate;
  late DateTime currentDate;
}
