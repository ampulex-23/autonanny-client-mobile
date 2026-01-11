import 'package:dio/dio.dart';
import 'package:mime/mime.dart'; // Для определения contentType файла
import 'package:nanny_core/api/request_builder.dart';
import 'package:nanny_core/nanny_core.dart';

class NannyFilesApi {
  static Future<ApiResponse<UploadedFiles>> uploadFiles(
      List<XFile> files) async {
    var formData = FormData();

    // Добавление файлов в FormData
    for (var file in files) {
      var mimeType = lookupMimeType(file.path) ??
          "application/octet-stream"; // Определяем MIME-тип файла
      var formFile = await MultipartFile.fromFile(
        file.path,
        filename: file.name, // Сохраняем полное имя файла
        contentType:
            MediaType.parse(mimeType), // Указываем корректный тип контента
      );

      formData.files.add(MapEntry('files', formFile));
    }

    try {
      // Выполнение запроса
      return RequestBuilder<UploadedFiles>().create(
        dioRequest: DioRequest.dio.post(
          "/files/upload_files",
          data: formData,
          options: Options(
            headers: {
              "accept": "application/json",
              "Authorization": "Bearer ${DioRequest.authToken}",
              "Content-Type": "multipart/form-data",
            },
          ),
        ),
        onSuccess: (response) => UploadedFiles.fromJson(response.data),
      );
    } catch (e) {
      // Логирование ошибок
      Logger().e("File upload failed: $e");
      rethrow; // Пробрасываем ошибку дальше, если нужно
    }
  }
}
