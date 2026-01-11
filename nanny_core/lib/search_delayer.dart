import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nanny_core/nanny_core.dart';

class SearchDelayer<T> {
  SearchDelayer({
    required this.delay,
    required Future<ApiResponse<T>> initRequest,
    required VoidCallback update,
  }) {
    _request = initRequest;
    _update = update;
  }

  final Duration delay;
  late final VoidCallback _update;

  Timer _timer = Timer(Duration.zero, () {});
  late Future<ApiResponse<T>> _request;

  Future<ApiResponse<T>> get request => _request;
  bool get isLoading => _timer.isActive;

  Future<void> wait({required Future<ApiResponse<T>> onCompleteRequest}) async {
    _timer.cancel();
    _update();
    _rearmTimer(onCompleteRequest);
  }

  void updateRequest(Future<ApiResponse<T>> request) {
    _request = request;
    _update();
  }

  void clear() {
    if (_timer.isActive) {
      _timer.cancel(); // Останавливаем таймер, если он активен
    }
    _request = Future.value(
        ApiResponse<T>.empty()); // Сбрасываем запрос в пустой результат
    _update(); // Обновляем состояние
  }

  void _rearmTimer(Future<ApiResponse<T>> onCompleteRequest) => _timer = Timer(
        delay,
        () => updateRequest(onCompleteRequest),
      );
}
