import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          HomeScreen(rtspCameraAddress: 'rtsp://192.168.144.25:8554/main.264'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String rtspCameraAddress;

  const HomeScreen({Key? key, required this.rtspCameraAddress})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VlcPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initVlcPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initVlcPlayer() {
    try {
      _controller = VlcPlayerController.network(widget.rtspCameraAddress);
    } catch (e) {
      _showErrorDialog('Video Yüklenirken Hata Oluştu');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  void _openSettingsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: VlcPlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
              placeholder: Center(child: CircularProgressIndicator()),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: _openSettingsScreen,
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'U:88 D:89',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'BATT:%90',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '16.25',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '21.05.1799',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Device Ready',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '148/200',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '12.7',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'x2',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '355',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '342',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'x1',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'HUMAN',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'CAR',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Ayarlar Ekranı'),
      ),
    );
  }
}
