import 'package:flutter/material.dart';
import 'package:rc_bykaantium/screens/home_screen.dart'; // HomeScreen dosyasının doğru yolunu ekleyin

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H12 Remote Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(
        key: UniqueKey(), // UniqueKey kullanarak key parametresini ekleyin
        rtspCameraAddress:
            'rtsp://192.168.144.25:8554/main.264', // Örnek bir RTSP kamera adresi
      ),
    );
  }
}
