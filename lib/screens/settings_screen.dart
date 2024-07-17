import 'package:flutter/material.dart';
import 'package:rc_bykaantium/screens/home_screen.dart';

class SettingsScreen extends StatefulWidget {
  final String situationData;

  const SettingsScreen({Key? key, required this.situationData}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool sunMode = true;
  bool humanSelected = false;
  bool carSelected = false;
  bool setDeviceSelected = false;
  bool controlSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBackButton(),
            _buildConnectionPanel(),
            _buildCameraPanel(),
            _buildDevicePanel(),
            _buildSituationPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildConnectionPanel() {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Connection", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Forced to stop action
              },
              child: Text("Forced To Stop"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                (context.findAncestorStateOfType<HomeScreenState>())?.initVlcPlayer();
              },
              child: Text("Start Camera"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPanel() {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Camera", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text("Zoom: x2"),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("SUN"),
                Switch(
                  value: sunMode,
                  onChanged: (value) {
                    setState(() {
                      sunMode = value;
                    });
                  },
                ),
                Text("MOON"),
              ],
            ),
            _buildObjectPanel(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                (context.findAncestorStateOfType<HomeScreenState>())?.startTcpCommunication();
              },
              child: Text("Start TCP"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildObjectPanel() {
    return Card(
      margin: EdgeInsets.only(top: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Object", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildToggleButton("Human", humanSelected, () {
                  setState(() {
                    humanSelected = !humanSelected;
                  });
                }),
                _buildToggleButton("Car", carSelected, () {
                  setState(() {
                    carSelected = !carSelected;
                  });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green : Colors.grey,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Widget _buildDevicePanel() {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Device", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text("Speed: x2"),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildToggleButton("Set Device", setDeviceSelected, () {
                  setState(() {
                    setDeviceSelected = !setDeviceSelected;
                  });
                }),
                _buildToggleButton("Control", controlSelected, () {
                  setState(() {
                    controlSelected = !controlSelected;
                  });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSituationPanel() {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("SITUATION", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Text(
                widget.situationData,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
