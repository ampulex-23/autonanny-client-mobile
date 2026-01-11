import 'dart:async';
import 'package:nanny_core/nanny_core.dart';

class NannyWebSocket {
  NannyWebSocket();
  NannyWebSocket._({
    required this.channel,
    required this.stream,
    required this.sink,
  }) {
    _sub = stream.listen(
      (data) {
        Logger().i("🟢 Received data:\n$data\nFrom address: $address");
      },
      onError: (error) {
        Logger().e("🔴 Error in stream:\n$error");
      },
      onDone: () {
        Logger().w("⚠️ Stream closed for address: $address");
        _connected = false;
      },
      cancelOnError: true,
    );
    _connected = true;
    Logger().i("✅ WebSocket subscription initialized for address: $address");
  }

  late final WebSocketChannel channel;
  late final Stream stream;
  late final WebSocketSink sink;
  late final StreamSubscription _sub;

  bool _connected = false;
  bool get connected => _connected;

  String get address => ""; // Убедись, что здесь возвращается корректный адрес

  Future<NannyWebSocket> connect() async {
    try {
      Logger().i("🔄 Attempting to connect to WebSocket at address: $address");
      var channel = WebSocketChannel.connect(Uri.parse(address));
      await channel.ready;
      _connected = true;

      Logger().i("✅ Successfully connected to WebSocket at address: $address");

      return NannyWebSocket._(
        channel: channel,
        stream: channel.stream.asBroadcastStream(),
        sink: channel.sink,
      );
    } catch (e) {
      Logger().e("❌ Failed to connect to WebSocket: $e");
      rethrow;
    }
  }

  void send(String message) {
    if (_connected) {
      Logger().i("📤 Sending message:\n$message");
      sink.add(message);
    } else {
      Logger().w("⚠️ Attempted to send message while disconnected:\n$message");
    }
  }

  void dispose() {
    try {
      Logger().w("🛑 Disposing WebSocket at address: $address");
      sink.close();
      _sub.cancel();
      _connected = false;
      Logger().i("✅ WebSocket successfully disposed");
    } catch (e) {
      Logger().e("❌ Error during WebSocket disposal: $e");
    }
  }
}
