import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/view_models/referral_program_vm.dart';
import 'package:nanny_components/nanny_components.dart';

class ReferralProgramView extends StatefulWidget {
  const ReferralProgramView({super.key});

  @override
  State<ReferralProgramView> createState() => _ReferralProgramViewState();
}

class _ReferralProgramViewState extends State<ReferralProgramView> {
  late ReferralProgramVm vm;

  @override
  void initState() {
    super.initState();
    vm = ReferralProgramVm(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NannyTheme.secondary,
      appBar: const NannyAppBar(
          title: "Реферальная программа",
          color: NannyTheme.secondary,
          isTransparent: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: NannyTextForm(
              style: NannyTextFormStyles.searchForm,
              hintText: "Поиск",
              onChanged: (text) => vm.search(text),
            ),
          ),
          Expanded(
            child: RequestLoader(
              completeView: (context, data) => (data ?? []).isEmpty
                  ? const Center(
                      child: Text("Список пуст..."),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => ListTile(
                            minLeadingWidth: 0,
                            minTileHeight: 0,
                            minVerticalPadding: 0,
                            onTap: () => vm.navigateToPartner(data[index].id),
                            leading: ProfileImage(
                              url: data[index].photoPath,
                              radius: 50,
                            ),
                            title: Text(
                                "${data[index].name} ${data[index].surname}",
                                style: const TextStyle(
                                    fontFamily: 'Nanito',
                                    color: NannyTheme.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    height: 17.6 / 16),
                                softWrap: true),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                data[index]
                                    .role
                                    .map((e) =>
                                        e.name == "Администратор франшизы"
                                            ? "Франшиза"
                                            : e.name)
                                    .join(',\n'),
                                style: const TextStyle(
                                    fontFamily: 'Nanito',
                                    color: Color(0xFF6D6D6D),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 17.6 / 16),
                              ),
                            ),
                            trailing: Text(
                              data[index].dateReg,
                              style: const TextStyle(
                                  fontFamily: 'Nanito',
                                  color: Color(0xFF6D6D6D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 16.8 / 12),
                            ),
                          ),
                      separatorBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(color: NannyTheme.grey),
                          ),
                      itemCount: data!.length),
              request: vm.delayer.request,
              errorView: (context, error) => ErrorView(
                errorText: error.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
