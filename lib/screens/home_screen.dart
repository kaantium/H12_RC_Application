import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import '../services/mavlink_service.dart';
import '../widgets/settings_button.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final String rtspCameraAddress;

  const HomeScreen({Key? key, required this.rtspCameraAddress})
      : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  VlcPlayerController? _vlcController;
  MavlinkService? _mavlinkService;
  String _situationData = "No data";
  bool _isCameraConnected = true;
  String _cameraErrorMessage = "";
  bool _isTcpConnected = false;

  @override
  void initState() {
    super.initState();
  }

  void initVlcPlayer() {
    _vlcController = VlcPlayerController.network(
      widget.rtspCameraAddress,
      hwAcc: HwAcc.full,
      autoPlay: true,
      // ignore: deprecated_member_use
      onInit: () {
        _checkCameraConnection();
        _vlcController?.addListener(_checkCameraConnection);
      },
    );
  }

  void _checkCameraConnection() {
    if (_vlcController == null ||
        !_vlcController!.value.isInitialized ||
        _vlcController!.value.hasError) {
      setState(() {
        _isCameraConnected = false;
        _cameraErrorMessage =
            "Failed to connect to RTSP server. Please check the connection.";
      });
    } else {
      setState(() {
        _isCameraConnected = true;
        _cameraErrorMessage = "";
      });
    }
  }

  void startTcpCommunication() {
    _mavlinkService = MavlinkService();
    _mavlinkService!.connect('127.0.0.1', 5760);
    _mavlinkService!.dataStream.listen((data) {
      setState(() {
        _situationData = data;
      });
    }, onDone: () {
      setState(() {
        _isTcpConnected = false;
      });
    }, onError: (error) {
      setState(() {
        _isTcpConnected = false;
      });
    });
    setState(() {
      _isTcpConnected = true;
    });
  }

  void stopTcpCommunication() {
    _mavlinkService?.disconnect();
    setState(() {
      _isTcpConnected = false;
    });
  }

  @override
  void dispose() {
    _vlcController?.removeListener(_checkCameraConnection);
    _vlcController?.dispose();
    _mavlinkService?.dispose();
    super.dispose();
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
      MaterialPageRoute(
          builder: (context) => SettingsScreen(situationData: _situationData)),
    );
  }

  Widget _buildCameraView() {
    if (_vlcController == null) {
      return Center(
        child: Text(
          "Press the button to start the camera",
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return Center(
      child: _isCameraConnected
          ? VlcPlayer(
              controller: _vlcController!,
              aspectRatio: 16 / 9,
              placeholder: Center(child: CircularProgressIndicator()),
            )
          : Center(
              child: Text(
                _cameraErrorMessage,
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
    );
  }

  Widget _buildStatusRow(List<String> statuses) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: statuses
          .map((status) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    status,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildCameraView(),
          Positioned(
            top: 16,
            left: 16,
            child: SettingsButton(
              onPressed: _openSettingsScreen,
              rtspCameraAddress: widget.rtspCameraAddress,
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: _buildStatusRow(
                ['U:88 D:89', 'BATT:%90', '16.25', '21.05.1799']),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: _buildStatusRow(
                ['Device Ready', '148/200', '12.7', 'x2', '355']),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildStatusRow(['342']),
                SizedBox(height: 8),
                _buildStatusRow(['x1']),
                SizedBox(height: 8),
                _buildStatusRow(['HUMAN']),
                SizedBox(height: 8),
                _buildStatusRow(['CAR']),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
