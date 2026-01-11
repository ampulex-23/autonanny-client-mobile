import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_components/base_views/views/graph_stats.dart';

class ReportsManagementView extends StatefulWidget {
  const ReportsManagementView({super.key});

  @override
  State<ReportsManagementView> createState() => _ReportsManagementViewState();
}

class _ReportsManagementViewState extends State<ReportsManagementView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NannyAppBar(
        title: "Управление отчетами",
        color: NannyTheme.secondary,
        isTransparent: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 34, bottom: 34),
        child: Column(
          children: [
            GraphStatsView(
              title: "Отчет о продажах",
              getUsersReport: false,
            ),
            SizedBox(height: 34),
            GraphStatsView(
              title: "Отчет о пользователях",
              getUsersReport: true,
            ),
          ],
        ),
      ),
    );
  }
}
