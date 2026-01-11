import 'dart:async';

import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/api/web_sockets/drive_search_socket.dart';
import 'package:nanny_core/api/web_sockets/nanny_web_socket.dart';
import 'package:nanny_core/nanny_core.dart';

class DriveSearchVM extends ViewModelBase {
  DriveSearchVM({
    required super.context,
    required super.update,
    required this.token,
  }) {
    subscription = _controller.stream.listen((v){
     print('found value ${v}');
    });
  }

  final _controller = StreamController.broadcast();
  StreamSubscription? subscription;

  final String token;
  late final NannyWebSocket socket;
  var socketValue;

  void dispose() {
    subscription = null;
    socket.dispose();
  }

  @override
  Future<bool> loadPage() async {
    socket = await DriveSearchSocket(token).connect();
    print('driver search with token $token');
    socket.stream.listen((event) {
      _controller.sink.add(event);
      Logger().w(event);
    });

    return true;
  }
}
