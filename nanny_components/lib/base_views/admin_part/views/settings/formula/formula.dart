import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';

class FormulaSettingView extends StatefulWidget {
  const FormulaSettingView({super.key});

  @override
  State<FormulaSettingView> createState() => _FormulaSettingViewState();
}

class _FormulaSettingViewState extends State<FormulaSettingView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: const NannyAppBar(
            title: "Коэффициенты и формулы",
            bottom: TabBar(
              indicatorColor: NannyTheme.primary,
              labelColor: NannyTheme.primary,
              unselectedLabelColor: NannyTheme.onSecondary,
              tabs: [
                Tab(text: "Разовые поездки"),
                Tab(text: "Тест"),
              ]
            ),
          ),
          // body: SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.all(20),
          //     child: Column(
          //       children: [
          //         Image.asset('packages/nanny_components/assets/images/formula.png'),
          //         Image.asset('packages/nanny_components/assets/images/formula_parts.png'),
          //       ],
          //     ),
          //   ),
          // ),
          body: TabBarView(
            children: [
              
            ]
          ),
        ),
      ),
    );
  }
}