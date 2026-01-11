import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nanny_components/dialogs/loading.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/api/api_models/create_user_request.dart';
import 'package:nanny_core/nanny_core.dart';

class PartnerCreateVM extends ViewModelBase {
  PartnerCreateVM({
    required super.context,
    required super.update,
  });

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController refController = TextEditingController();

  GlobalKey<FormState> phoneState = GlobalKey();
  GlobalKey<FormState> passwordState = GlobalKey();
  GlobalKey<FormState> refState = GlobalKey();

  String get phone => "7${phoneMask.getUnmaskedText()}";
  MaskTextInputFormatter phoneMask = TextMasks.phoneMask();

  String name = "";
  String surname = "";

  void createUser() async {
    if (phone.length < 11 ||
        validatePassword(passwordController.text) != null ||
        validateReferralLink(refController.text) != null) return;

    LoadScreen.showLoad(context, true);

    bool success = await DioRequest.handleRequest(
        context,
        NannyAdminApi.createUser(CreateUserRequest(
            phone: phone,
            password: passwordController.text,
            //name: name,
            //surname: surname,
            role: UserType.partner.id,
            referalCode: refController.text)));

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

    // Shuffle to randomize the order of characters
    password = String.fromCharCodes(password.runes.toList()..shuffle(random));

    // Update the password controller with the generated password
    passwordController.text = password;
  }

  void generateReferralLink() {
    const length = 32;
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();

    refController.text =
        List.generate(length, (index) => chars[random.nextInt(chars.length)])
            .join();
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

  String? validateReferralLink(String? link) {
    if (link == null || link.isEmpty) {
      return "Реферальная ссылка обязательна для заполнения";
    }
    if (link.length != 32) {
      return "Реферальная ссылка должна содержать 32 символа";
    }
    if (!RegExp(r'^[A-Z0-9]+$').hasMatch(link)) {
      return "Реферальная ссылка может содержать только заглавные буквы латиницы и цифры";
    }
    return null;
  }
}
