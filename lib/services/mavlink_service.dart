// lib/services/mavlink_service.dart
import 'dart:async';

class MavlinkService {
  // MAVLink protokolü ile komut gönderen fonksiyon
  void sendCommand(String command) {
    // MAVLink komut gönderme işlemleri burada gerçekleştirilecek.
    print('MAVLink Komutu Gönderildi: $command');
  }

  // MAVLink ile verileri alan fonksiyon
  Stream<String> getDataStream() async* {
    // Örnek veri akışı
    await Future.delayed(Duration(seconds: 1));
    yield 'İKA Verisi 1';
    await Future.delayed(Duration(seconds: 1));
    yield 'İKA Verisi 2';
  }
}
