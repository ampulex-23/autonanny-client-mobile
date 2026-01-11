class ApiResponse<T> {
  ApiResponse({
    this.success = false,
    this.statusCode = 400,
    this.errorMessage = "Запрос не сформирован",
    this.response,
  });

  final bool success;
  final int statusCode;
  final String errorMessage;
  final T? response;

  // Фабричный конструктор для пустого объекта
  factory ApiResponse.empty() {
    return ApiResponse<T>(
      success: false,
      statusCode: 400,
      errorMessage: "Нет данных",
      response: null,
    );
  }
}
