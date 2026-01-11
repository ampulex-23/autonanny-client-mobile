import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class GraphStatsVM extends ViewModelBase {
  GraphStatsVM({
    required super.context,
    required super.update,
    required this.getUsersReport,
  });

  final bool getUsersReport;
  DateType selectedDateType = DateType.day;
  List<double> data = [];

  void onSelect(Set<DateType> type) {
    update(() => selectedDateType = type.first);
    reloadPage();
  }

  void downloadReport() async {
    var dir = await getDownloadsDirectory();

    if (dir == null) {
      if (context.mounted) {
        NannyDialogs.showMessageBox(context, "Ошибка",
            "Не удалось получить директорию для загрузки файла!");
      }
      return;
    }

    var dateRange = getDateRange(selectedDateType);
    final startDate = dateRange.start.toIso8601String().split('T').first;
    final endDate = dateRange.end.toIso8601String().split('T').first;

    // Выбор нужного метода API
    var fileName = getUsersReport ? "users_report.pdf" : "sales_report.pdf";
    var filePath = "${dir.path}/$fileName";

    double downloaded = 0;
    void Function() updateLoad = () {};
    BuildContext? loadContext;
    CancelToken cancelToken = CancelToken();

    // Отображение прогресса загрузки
    NannyDialogs.showModalDialog(
      context: context,
      hasDefaultBtn: false,
      title: "Отменить загрузку",
      child: StatefulBuilder(
        builder: (lContext, setState) {
          updateLoad = () => setState(() {});
          loadContext = lContext;

          return Column(
            children: [
              SizedBox.square(
                dimension: 60,
                child: FittedBox(
                  child: LoadingView(progress: downloaded / 100),
                ),
              ),
              const SizedBox(height: 10),
              Text("${downloaded.toStringAsFixed(0)} %"),
            ],
          );
        },
      ),
    ).then((value) {
      if (value) cancelToken.cancel();
    });

    // Загрузка файла
    var dio = Dio(BaseOptions(
      baseUrl: NannyConsts.baseUrl,
      headers: {
        "Content-Type": "application/pdf",
        'Authorization': "Bearer ${DioRequest.authToken}",
        'accept': '*/*'
      },
      validateStatus: (status) => status != null,
    ));
    try {
      var response = await dio.post(
        getUsersReport ? "/admins/report_users" : "/admins/report_sales",
        queryParameters: {
          "start_date": startDate,
          "end_date": endDate,
        },
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (count, total) {
          downloaded = (count / total) * 100;
          updateLoad();
        },
        cancelToken: cancelToken,
      );

      // Сохранение файла
      var file = File(filePath);
      await file.writeAsBytes(response.data);

      if (loadContext!.mounted) Navigator.pop(loadContext!);

      // Открытие файла
      OpenFilex.open(filePath);
    } catch (e) {
      if (loadContext!.mounted) Navigator.pop(loadContext!);

      if (context.mounted) {
        NannyDialogs.showMessageBox(context, "Ошибка",
            "Не удалось загрузить файл или загрузка была отменена.");
      }
    }
  }

  @override
  Future<bool> loadPage() async {
    final dateRange = getDateRange(selectedDateType);
    final startDate = dateRange.start.toIso8601String().split('T').first;
    final endDate = dateRange.end.toIso8601String().split('T').first;

    ApiResponse<List<double>> res = await (getUsersReport
        ? NannyAdminApi.getUsersReportGraph(
            startDate: startDate,
            endDate: endDate,
          )
        : NannyAdminApi.getSalesReportGraph(
            startDate: startDate,
            endDate: endDate,
          ));

    if (!res.success) return false;

    // Заполняем отсутствующие дни, чтобы график был корректным
    final Map<String, double> fullData = {
      for (var i = 0; i <= dateRange.duration.inDays; i++)
        dateRange.start
            .add(Duration(days: i))
            .toIso8601String()
            .split('T')
            .first: 0,
    };

    res.response?.asMap().forEach((index, value) {
      final date = fullData.keys.elementAt(index);
      fullData[date] = value;
    });

    data = fullData.values.toList();
    return true;
  }
}

DateTimeRange getDateRange(DateType dateType) {
  final now = DateTime.now();

  switch (dateType) {
    case DateType.day:
      return DateTimeRange(
        start: now,
        end: now,
      );
    case DateType.week:
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      return DateTimeRange(start: startOfWeek, end: endOfWeek);
    case DateType.month:
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(now.year, now.month + 1, 0);
      return DateTimeRange(start: startOfMonth, end: endOfMonth);
    case DateType.year:
      final startOfYear = DateTime(now.year, 1, 1);
      final endOfYear = DateTime(now.year, 12, 31);
      return DateTimeRange(start: startOfYear, end: endOfYear);
  }
}
