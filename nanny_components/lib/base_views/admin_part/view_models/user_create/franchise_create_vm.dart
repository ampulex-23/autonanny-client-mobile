import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nanny_components/dialogs/loading.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/api/api_models/create_user_request.dart';
import 'package:nanny_core/api/api_models/static_data.dart';
import 'package:nanny_core/nanny_core.dart';

class FranchiseCreateVM extends ViewModelBase {
  FranchiseCreateVM({
    required super.context,
    required super.update,
  });

  final TextEditingController passwordController = TextEditingController();

  final List<FranchiseCheckBoxData> _items = [
    FranchiseCheckBoxData(
      checked: true,
      type: UserType.franchiseAdmin,
    ),
    FranchiseCheckBoxData(
      checked: false,
      type: UserType.manager,
    ),
    FranchiseCheckBoxData(
      checked: false,
      type: UserType.operator,
    ),
  ];
  List<FranchiseCheckBoxData> get items => _items;

  GlobalKey<FormState> phoneState = GlobalKey();
  GlobalKey<FormState> passwordState = GlobalKey();
  GlobalKey<FormState> cityState = GlobalKey();

  UserType selectedType = UserType.franchiseAdmin;

  String get phone => "7${phoneMask.getUnmaskedText()}";
  MaskTextInputFormatter phoneMask = TextMasks.phoneMask();

  String name = "";
  String surname = "";
  List<StaticData> selectedCities = [];

  void selectCity() async {
    var city = await showSearch(
        context: context,
        delegate: NannySearchDelegate(
          onSearch: (query) =>
              NannyStaticDataApi.getCities(StaticData(title: query)),
          onResponse: (response) => response.response,
        ));

    if (city == null) return;
    if (selectedCities.where((e) => e.id == city.id).isNotEmpty) return;

    selectedCities.add(city);
    update(() {});
  }

  void removeCity(StaticData city) {
    selectedCities.remove(city);
    update(() {});
  }

  void changeSelection(FranchiseCheckBoxData data) {
    for (var e in _items) {
      e.checked = false;
    }
    data.checked = true;
    selectedType = data.type;
    update(() {});
  }

  void createUser() async {
    if (!phoneState.currentState!.validate() ||
        !passwordState.currentState!.validate()) return;

    if (selectedCities.isEmpty) {
      NannyDialogs.showMessageBox(context, "Ошибка", "Выберите город(а)!");
      return;
    }

    LoadScreen.showLoad(context, true);

    bool success = await DioRequest.handleRequest(
        context,
        NannyAdminApi.createUser(CreateUserRequest(
            phone: phone,
            password: passwordController.text,
            //name: name,
            //surname: surname,
            role: selectedType.id,
            idCity: selectedCities.map((e) => e.id).toList())));

    if (!success) return;
    if (!context.mounted) return;

    LoadScreen.showLoad(context, false);

    await NannyDialogs.showMessageBox(context, "Успех", "Пользователь создан");

    if (!context.mounted) return;
    Navigator.pop(context);
  }

  Future<void> generatePassword({int length = 8}) async {
    const String upperCaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String lowerCaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String digits = '0123456789';
    const String specialCharacters = '!#\$%&?';

    // Generate password according to rules
    String password = '';
    final Random random = Random();

    password += upperCaseLetters[random.nextInt(upperCaseLetters.length)];
    password += lowerCaseLetters[random.nextInt(lowerCaseLetters.length)];
    password += digits[random.nextInt(digits.length)];
    password += specialCharacters[random.nextInt(specialCharacters.length)];

    String allAllowedCharacters =
        upperCaseLetters + lowerCaseLetters + digits + specialCharacters;

    while (password.length < length) {
      password +=
          allAllowedCharacters[random.nextInt(allAllowedCharacters.length)];
    }

    // Update the password controller with the generated password
    passwordController.text =
        String.fromCharCodes(password.runes.toList()..shuffle(random));
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Пароль обязателен для заполнения";
    }
    if (text.length < 8) {
      return "Пароль должен быть не менее 8 символов!";
    }
    if (!RegExp(r'[A-Z]').hasMatch(text)) {
      return "Пароль должен содержать хотя бы одну заглавную букву!";
    }
    if (!RegExp(r'[0-9]').hasMatch(text)) {
      return "Пароль должен содержать хотя бы одну цифру!";
    }
    if (!RegExp(r'[!#$%&?]').hasMatch(text)) {
      return "Пароль должен содержать хотя бы один специальный символ из !#\$%&?";
    }
    if (RegExp(r'\s').hasMatch(text)) {
      return "Пароль не должен содержать пробелы!";
    }
    if (!RegExp(r'^[A-Za-z0-9!#$%&?]+$').hasMatch(text)) {
      return "Пароль должен содержать только латинские буквы!";
    }
    return null;
  }
}

class FranchiseCheckBoxData {
  FranchiseCheckBoxData({required this.checked, required this.type});

  bool checked;
  final UserType type;
}
