import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/view_models/user_create/user_create_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:time_range_picker/time_range_picker.dart';

class UserCreateView extends StatefulWidget {
  const UserCreateView({super.key});

  @override
  State<UserCreateView> createState() => _UserCreateViewState();
}

class _UserCreateViewState extends State<UserCreateView> {
  late UserCreateVM vm;

  @override
  void initState() {
    super.initState();
    vm = UserCreateVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NannyAppBar(
        title: "Создание пользователя",
        color: NannyTheme.secondary,
        isTransparent: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 16, right: 16),
          child: Column(
            children: [
              createButton(
                name: "Франшиза",
                photoPath: "franchise_create.png",
                userCreatedType: UserCreatedType.franchise,
                onTap: vm.toFranchiseCreate,
              ),
              const SizedBox(height: 15),
              createButton(
                name: "Партнер",
                photoPath: "partner_create.png",
                userCreatedType: UserCreatedType.user,
                onTap: vm.toPartnerCreate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createButton(
      {required String name,
      required String photoPath,
      required UserCreatedType userCreatedType,
      required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: userCreatedType == UserCreatedType.franchise ? 7 : 11,
            spreadRadius: userCreatedType == UserCreatedType.franchise ? 0 : -6,
            color: userCreatedType == UserCreatedType.franchise
                ? const Color(0xFF171170).withOpacity(.11)
                : const Color(0xFF0D5118).withOpacity(.5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: NannyButtonStyles.whiteButton.copyWith(
          maximumSize: const WidgetStatePropertyAll(
            Size(double.infinity, 118),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          elevation: const WidgetStatePropertyAll(0),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.only(left: 16, right: 10, top: 9, bottom: 9),
          ),
          backgroundColor: WidgetStatePropertyAll(
              userCreatedType == UserCreatedType.franchise
                  ? NannyTheme.lightPink
                  : NannyTheme.lightGreen),
        ),
        onPressed: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 17),
                child: Text(
                  name,
                  style: NannyTextStyles.defaultTextStyle
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
            Image.asset(
              'packages/nanny_components/assets/images/$photoPath',
            )
          ],
        ),
      ),
    );
  }
}
