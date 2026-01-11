import 'package:flutter/material.dart';
import 'package:nanny_components/styles/button_styles.dart';
import 'package:nanny_core/models/from_api/drive_and_map/today_schedule_data.dart';

class TodayScheduleView extends StatelessWidget {
  final TodayScheduleData schedule;
  final VoidCallback onPressed;
  
  const TodayScheduleView({
    super.key,
    required this.schedule,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: NannyButtonStyles.whiteButton,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(schedule.parentName),
              Text(schedule.title, style: const TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          Center( child: Text(schedule.time) ),
        ],
      ),
    );
  }
}