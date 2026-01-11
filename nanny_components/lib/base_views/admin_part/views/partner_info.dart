import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanny_components/base_views/admin_part/view_models/partner_info_vm.dart';
import 'package:nanny_components/base_views/admin_part/views/referal_info.dart';
import 'package:nanny_components/nanny_components.dart';

class PartnerInfoView extends StatefulWidget {
  final int partnerId;

  const PartnerInfoView({
    super.key,
    required this.partnerId,
  });

  @override
  State<PartnerInfoView> createState() => _PartnerInfoViewState();
}

class _PartnerInfoViewState extends State<PartnerInfoView> {
  late PartnerInfoVM vm;

  @override
  void initState() {
    super.initState();
    vm = PartnerInfoVM(
        context: context, update: setState, partnerId: widget.partnerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NannyTheme.secondary,
      appBar: const NannyAppBar(
          title: "Партнер", color: NannyTheme.secondary, isTransparent: false),
      body: RequestLoader(
        request: vm.request,
        completeView: (context, data) => AdaptBuilder(builder: (context, size) {
          if (data == null) {
            return const ErrorView(
                errorText: "Партнер не состоит ни в одной франшизе");
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
                labelText: "Реферальная ссылка",
                initialValue: data.roleData!.referalCode,
                readOnly: true,
                suffixIcon: IconButton(
                  onPressed: () => vm.copyCode(data.roleData!.referalCode),
                  icon: const Icon(Icons.copy),
                  splashRadius: 25,
                ),
              ),
              const SizedBox(height: 16),
              NannyTextForm(
                isExpanded: true,
                labelText: "% кешбека",
                initialValue: data.roleData!.referalPercent.toString(),
                hintText: data.roleData!.referalPercent.toString(),
                keyType: TextInputType.number,
                readOnly: true,
                formatters: [FilteringTextInputFormatter.digitsOnly],
                //suffixIcon: Padding(
                //  padding: const EdgeInsets.all(5),
                //  child: SizedBox(
                //    width: 60,
                //    child: ElevatedButton(
                //        onPressed: vm.savePercent,
                //        child: const Icon(Icons.save)),
                //  ),
                //),
              ),
              const SizedBox(height: 27),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => vm.listSwitch(true),
                        style: vm.showReferals
                            ? null
                            : NannyButtonStyles.whiteButton,
                        child: const Text("Рефералы")),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => vm.listSwitch(false),
                        style: vm.showReferals
                            ? NannyButtonStyles.whiteButton
                            : null,
                        child: const Text("Заявки")),
                  ),
                ],
              ),
              vm.showReferals
                  ? data.roleData!.referals.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 150),
                            child: Text("Список пуст..."),
                          ),
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemBuilder: (context, index) => Column(
                                children: [
                                  if (index == 0)
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Divider(color: NannyTheme.grey),
                                    ),
                                  ListTile(
                                    minLeadingWidth: 0,
                                    minTileHeight: 0,
                                    minVerticalPadding: 0,
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () => vm.navigateToView(
                                        ReferalInfoView(
                                            referalId: data
                                                .roleData!.referals[index].id)),
                                    title: Text(
                                        "${data.roleData!.referals[index].name} ${data.roleData!.referals[index].surname}",
                                        style: const TextStyle(
                                            color: Color(0xFF212121),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: 17.6 / 16),
                                        softWrap: true),
                                    trailing: Text(
                                      data.roleData!.referals[index].dateReg,
                                      style: const TextStyle(
                                          color: Color(0xFF6D6D6D),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 16.8 / 12),
                                    ),
                                  ),
                                ],
                              ),
                          separatorBuilder: (context, index) => const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Divider(color: NannyTheme.grey),
                              ),
                          itemCount: data.roleData!.referals.length)
                  : true
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 150),
                            child: Text("Список пуст..."),
                          ),
                        )
                      : ListView(
                          shrinkWrap: true,
                          children: const [], // TODO: API!!!
                        ),
            ],
          );
        }),
        errorView: (context, error) => ErrorView(errorText: error.toString()),
      ),
    );
  }
}
