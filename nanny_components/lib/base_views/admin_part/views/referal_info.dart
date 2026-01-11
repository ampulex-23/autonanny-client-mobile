import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/view_models/referal_info_vm.dart';
import 'package:nanny_components/nanny_components.dart';

class ReferalInfoView extends StatefulWidget {
  final int referalId;

  const ReferalInfoView({
    super.key,
    required this.referalId,
  });

  @override
  State<ReferalInfoView> createState() => _ReferalInfoViewState();
}

class _ReferalInfoViewState extends State<ReferalInfoView> {
  late final ReferalInfoVM vm;

  @override
  void initState() {
    super.initState();
    vm = ReferalInfoVM(
        context: context, update: setState, referalId: widget.referalId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NannyTheme.secondary,
      appBar: const NannyAppBar(
        title: "Партнер",
        color: NannyTheme.secondary,
        isTransparent: false,
      ),
      body: RequestLoader(
        request: vm.request,
        completeView: (context, data) => AdaptBuilder(
          builder: (context, size) {
            if (data == null) {
              return const ErrorView(
                  errorText: "Реферал не является водителем");
            }

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              children: [
                Row(
                  children: [
                    ProfileImage(
                        url: data.photoPath, radius: size.shortestSide * .3),
                    const SizedBox(width: 29),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data.name} ${data.surname}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  height: 20 / 18,
                                  fontWeight: FontWeight.w600,
                                  color: NannyTheme.onSecondary),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              TextMasks.phoneMask().maskText(data.phone),
                              style: const TextStyle(
                                  fontSize: 18,
                                  height: 20 / 18,
                                  fontWeight: FontWeight.w600,
                                  color: NannyTheme.darkGrey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                NannyTextForm(
                  isExpanded: true,
                  labelText: "% кешбека",
                  readOnly: true,
                  initialValue: data.roleData!.referalPercent.toString(),
                  hintText: data.roleData!.referalPercent.toString(),
                ),
                const SizedBox(height: 16),
                NannyTextForm(
                  isExpanded: true,
                  labelText: "Дата перехода по ссылке партнера",
                  readOnly: true,
                  initialValue: data.dateReg,
                  hintText: data.dateReg,
                ),
              ],
            );
          },
        ),
        errorView: (context, error) => ErrorView(errorText: error.toString()),
      ),
    );
  }
}
