import 'package:flutter/material.dart';
import 'package:nanny_components/dialogs/loading.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class OtherParamsVM extends ViewModelBase {
  OtherParamsVM({
    required super.context,
    required super.update,
  });

  void paramAction(Future<ApiResponse> request,
      {List<BuildContext>? previewDialogContexts}) async {
    LoadScreen.showLoad(context, true);

    bool success = await DioRequest.handleRequest(context, request);

    if (!success) return;
    if (!context.mounted) return;

    LoadScreen.showLoad(context, false);

    // закрываем все предыдущие диалоги, если есть
    if (previewDialogContexts != null) {
      for (BuildContext element in previewDialogContexts) {
        Navigator.pop(element);
      }
    }

    NannyDialogs.showMessageBox(context, "Успех", "Данные изменены!");

    update(() {});
  }

  String formatCurrency(double balance) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    String formatted =
        formatter.format(balance).replaceAll(',', ' ').replaceAll('.', ', ');
    return "$formatted Р";
  }
}
