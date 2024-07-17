import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String rtspCameraAddress;
  final VoidCallback onPressed;

  const SettingsButton({
    Key? key,
    required this.rtspCameraAddress,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: onPressed,
    );
  }
}
