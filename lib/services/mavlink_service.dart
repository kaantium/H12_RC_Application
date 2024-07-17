import 'dart:async';
import 'dart:convert';
import 'dart:io';

class MavlinkService {
  Socket? _socket;
  StreamController<String> _dataStreamController = StreamController.broadcast();
  StreamSubscription? _subscription;

  Stream<String> get dataStream => _dataStreamController.stream;

  void connect(String host, int port) async {
    try {
      _socket = await Socket.connect(host, port);
      _subscription = _socket!.listen((data) {
        _dataStreamController.add(utf8.decode(data));
      });
    } catch (e) {
      _dataStreamController.addError('Connection error: $e');
    }
  }

  void disconnect() {
    _subscription?.cancel();
    _socket?.close();
  }

  void sendCommand(String command) {
    _socket?.write(command);
  }

  void dispose() {
    _subscription?.cancel();
    _socket?.destroy();
    _dataStreamController.close();
  }
}
