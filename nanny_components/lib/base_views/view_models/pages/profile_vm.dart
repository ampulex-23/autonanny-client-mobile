import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/views/app_settings.dart';
import 'package:nanny_components/dialogs/loading.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/api/api_models/update_me_request.dart';
import 'package:nanny_core/nanny_core.dart';

class ProfileVM extends ViewModelBase {
  ProfileVM({
    required super.context, 
    required super.update,
    required this.logoutView,
  });

  final Widget logoutView;
  String? firstName;
  String? lastName;
  String? photoPath;
  int? inn;

  void changePassword() async {
    String? password;

    bool? checked = await _checkOldPassword();
    if(checked == null) return;
    if(!checked) {
      if(!context.mounted) return;

      NannyDialogs.showMessageBox(
        context, 
        "Ошибка", 
        "Пароли не совпали!"
      );

      return;
    }

    if(!context.mounted) return;

    password = await _promtChangePass();

    if(password == null) return;
    if(!context.mounted) return;

    if(password.isEmpty || password.length < 8) {
      NannyDialogs.showMessageBox(
        context, 
        "Ошибка", 
        "Пароль должен быть не меньше 8 символов!"
      );
      return;
    }

    bool success = await DioRequest.handleRequest(
      context, 
      NannyUsersApi.updateMe(
        UpdateMeRequest(
          password: password,
        )
      ),
    );

    if(!success) return;

    var data = (await NannyStorage.getLoginData())!;
    NannyStorage.updateLoginData(
      LoginStorageData(
        login: data.login, 
        password: password, 
        // haveSetPincode: data.haveSetPincode,
      ),
    );
    
    if(!context.mounted) return;

    LoadScreen.showLoad(context, false);
    NannyDialogs.showMessageBox(context, "Успех", "Пароль успешно измен");
  }

  Future<bool?> _checkOldPassword() async {
    String password = "";

    bool keepGoing = await NannyDialogs.showModalDialog(
      context: context, 
      title: "Введите старый пароль",
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: NannyPasswordForm(
            onChanged: (text) => password = text,
          ),
        )
      ),
    );
    if(!keepGoing) return null;

    var loginData = await NannyStorage.getLoginData();

    Logger().w("Login data - ${loginData!.password}");
    Logger().w("Password - ${Md5Converter.convert(password)}");

    if(Md5Converter.convert(password) != loginData.password) return false;
    return true;
  }

  Future<String?> _promtChangePass() async {
    String? password;
    bool keepGoing = await NannyDialogs.showModalDialog(
      context: context,
      title: "Введите новый пароль",
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: NannyPasswordForm(
            onChanged: (text) => password = text,
          ),
        ),
      )
    );
    if(!keepGoing) return null;

    return password;
  }

  void changeProfilePhoto() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file == null) return;
    if(!context.mounted) return;

    LoadScreen.showLoad(context, true);

    var upload = NannyFilesApi.uploadFiles([file]);
    bool uploaded = await DioRequest.handleRequest(
      context, 
      upload,
    );

    if(!uploaded) return;
    if(!context.mounted) return;

    LoadScreen.showLoad(context, true);
    
    bool updated = await DioRequest.handleRequest(
      // ignore: use_build_context_synchronously
      context, 
      NannyUsersApi.updateMe(
        UpdateMeRequest(
          photoPath: (await upload).response!.paths.first,
        )
      ),
    );

    if(!updated) return;
    if(!context.mounted) return;

    LoadScreen.showLoad(context, false);
    NannyDialogs.showMessageBox(
      context, 
      "Успех", 
      "Фото профиля обновлено!"
    );
    await NannyUser.getMe();

    update(() {});
  }

  void changePincode() async {
    String code = "";
    bool proceed = await NannyDialogs.showModalDialog(
      context: context, 
      title: "Введите старый пин-код",
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: NannyPasswordForm(
          onChanged: (text) => code = text,
          keyType: TextInputType.number,
          formatters: [
            MaskTextInputFormatter(
              mask: "####",
              filter: {
                '#': RegExp(r"[0-9]"),
              }
            )
          ],
        ),
      ),
    );

    if(!proceed) return;

    if(!context.mounted) return;

    LoadScreen.showLoad(context, true);

    bool success = await DioRequest.handleRequest(
      context, 
      NannyAuthApi.checkPinCode(code),
    );

    if(!success) return;

    if(!context.mounted) return;

    LoadScreen.showLoad(context, false);

    code = "";
    bool confirm = await NannyDialogs.showModalDialog(
      context: context, 
      title: "Введите новый пин-код",
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: NannyPasswordForm(
          onChanged: (text) => code = text,
          keyType: TextInputType.number,
          formatters: [
            MaskTextInputFormatter(
              mask: "####",
              filter: {
                '#': RegExp(r"[0-9]"),
              }
            )
          ],
        ),
      ),
    );

    if(!confirm) return;
    if(code.length < 4) {
      if(context.mounted) NannyDialogs.showMessageBox(context, "Ошибка", "Пин-код должен состоять из 4-х цифр");
      return;
    }

    if(!context.mounted) return;

    LoadScreen.showLoad(context, true);

    bool changed = await DioRequest.handleRequest(
      context, 
      NannyAuthApi.setPinCode(code),
    );

    if(!changed) return;
    if(!context.mounted) return;

    LoadScreen.showLoad(context, false);
    NannyDialogs.showMessageBox(context, "Успех", "Пин-код изменён");
  }
  
  void saveChanges() async {
    if(firstName == null || lastName == null) return;
    if(firstName!.isEmpty || lastName!.isEmpty) return;
    
    LoadScreen.showLoad(context, true);
    
    bool success = await DioRequest.handleRequest(
      context, 
      NannyUsersApi.updateMe(
        UpdateMeRequest(
          firstName: firstName,
          lastName: lastName,
        )
      ),
    );

    if(!success) return;

    await NannyUser.getMe();

    if(!context.mounted) return;

    LoadScreen.showLoad(context, false);

    NannyDialogs.showMessageBox(
      context, 
      "Успех", 
      "Данные обновлены!"
    );

    update(() {});
  }

  void logout() async {
    var success = await DioRequest.handleRequest(
      context, 
      NannyUser.logout()
    );

    if(!success) return;
    if(!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context) => logoutView), 
      (route) => false
    );
  }

  void navigateToAppSettings() => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AppSettingsView()),
  );

  void navigateToChildren() {
    // This method will be overridden in client-specific ProfileVM
  }
}