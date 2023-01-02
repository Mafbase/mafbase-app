import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

abstract class BaseSocket {
  final StreamController _controller = StreamController.broadcast();
  Stream get stream => _controller.stream;
  WebSocketChannel? _socket;
  final String url;
  bool _manualDone = false;

  BaseSocket(this.url);


  void connect() {
    _socket?.sink.close();
    _socket = WebSocketChannel.connect(Uri.parse(url));
    _socket?.stream.listen(_onMessage);
    _socket?.sink.done.then((_) async {
      if (!_manualDone) {
        await Future.delayed(const Duration(seconds: 3));
        connect();
      }
    });
  }

  void dispose() {
    _manualDone = true;
    _socket?.sink.close();
  }

  void _onMessage(dynamic message) {
    _controller.add(message);
  }
}