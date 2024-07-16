import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String rtspCameraAddress; // rtspCameraAddress parametresi eklendi

  const SettingsButton({
    Key? key,
    required this.rtspCameraAddress, // rtspCameraAddress zorunlu parametre olarak tanımlandı
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        // Ayarlar butonuna tıklandığında yapılacak işlemler
        // Örneğin, ayarlar ekranını açabilir veya rtspCameraAddress'i güncelleyebilirsiniz.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ayarlar'),
              content: Text('RTSP Kamera Adresi: $rtspCameraAddress'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Kapat'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
