import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final String rtspCameraAddress;

  const SettingsScreen({
    Key? key,
    required this.rtspCameraAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'rtsp://192.168.144.25:8554/main.264',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              rtspCameraAddress,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // RTSP kamera adresini kullanarak işlemler yapabilirsiniz
                // Örneğin, adresi başka bir widget veya işlevde kullanabilirsiniz
                // veya ayarlar bölümünden bu adresi güncelleyebilirsiniz.
              },
              child: Text('Kamerayı Bağla'),
            ),
          ],
        ),
      ),
    );
  }
}
