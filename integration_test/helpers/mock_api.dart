import 'package:dio/dio.dart';
import 'package:nanny_core/nanny_core.dart';

/// Mock API для integration тестов
/// 
/// Предоставляет фейковые данные для тестирования без реального бэкенда
class MockApi {
  /// Настройка mock Dio client
  static Dio createMockDio() {
    final dio = Dio(BaseOptions(
      baseUrl: 'http://mock-api.test',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    // Добавляем interceptor для перехвата запросов
    dio.interceptors.add(MockInterceptor());

    return dio;
  }

  /// Mock данные для тестов
  static final mockChildren = [
    {
      'id': 1,
      'name': 'Иван',
      'surname': 'Иванов',
      'patronymic': 'Петрович',
      'id_user': 1,
      'age': 8,
      'birthday': '2015-05-15',
      'gender': 'M',
      'school_class': '2А класс',
      'isActive': true,
    },
    {
      'id': 2,
      'name': 'Мария',
      'surname': 'Петрова',
      'id_user': 1,
      'age': 6,
      'birthday': '2017-08-20',
      'gender': 'F',
      'school_class': '1Б класс',
      'isActive': true,
    },
  ];

  static final mockTariffs = [
    {
      'id': 1,
      'title': 'Стандарт',
      'price': 500.0,
      'description': 'Базовый тариф',
    },
    {
      'id': 2,
      'title': 'Премиум',
      'price': 800.0,
      'description': 'Расширенный тариф',
    },
  ];

  static final mockUser = {
    'id': 1,
    'name': 'Тест',
    'surname': 'Пользователь',
    'phone': '+79001234567',
    'photo_path': '/photos/user1.jpg',
  };

  static final mockSchedules = [
    {
      'id': 1,
      'title': 'Утренняя школа',
      'id_user': 1,
      'id_tariff': 1,
      'duration': 7,
      'isActive': true,
    },
  ];
}

/// Interceptor для перехвата и mock ответов
class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Проверяем путь запроса и возвращаем mock данные
    final path = options.path;

    if (path.contains('/users/children')) {
      if (options.method == 'GET') {
        return handler.resolve(
          Response(
            requestOptions: options,
            data: {
              'status': true,
              'children': MockApi.mockChildren,
              'total': MockApi.mockChildren.length,
            },
            statusCode: 200,
          ),
        );
      } else if (options.method == 'POST') {
        // Создание нового ребёнка
        final newChild = {
          'id': 3,
          ...options.data as Map<String, dynamic>,
          'isActive': true,
        };
        return handler.resolve(
          Response(
            requestOptions: options,
            data: {
              'status': true,
              'child': newChild,
            },
            statusCode: 201,
          ),
        );
      }
    }

    if (path.contains('/tariffs')) {
      return handler.resolve(
        Response(
          requestOptions: options,
          data: {
            'status': true,
            'tariffs': MockApi.mockTariffs,
          },
          statusCode: 200,
        ),
      );
    }

    if (path.contains('/users/me')) {
      return handler.resolve(
        Response(
          requestOptions: options,
          data: {
            'status': true,
            'user': MockApi.mockUser,
          },
          statusCode: 200,
        ),
      );
    }

    if (path.contains('/schedules')) {
      if (options.method == 'GET') {
        return handler.resolve(
          Response(
            requestOptions: options,
            data: {
              'status': true,
              'schedules': MockApi.mockSchedules,
            },
            statusCode: 200,
          ),
        );
      } else if (options.method == 'POST') {
        // Создание нового графика
        final newSchedule = {
          'id': 2,
          ...options.data as Map<String, dynamic>,
          'isActive': true,
        };
        return handler.resolve(
          Response(
            requestOptions: options,
            data: {
              'status': true,
              'schedule': newSchedule,
            },
            statusCode: 201,
          ),
        );
      }
    }

    // Для всех остальных запросов возвращаем успех
    handler.resolve(
      Response(
        requestOptions: options,
        data: {'status': true},
        statusCode: 200,
      ),
    );
  }
}

/// Инициализация mock API для тестов
void setupMockApi() {
  // Заменяем DioRequest на mock версию
  // TODO: Требует рефакторинга DioRequest для поддержки dependency injection
  // DioRequest.dio = MockApi.createMockDio();
}
