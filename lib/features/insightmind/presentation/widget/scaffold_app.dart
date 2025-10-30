import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScaffoldApp extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final bool isFullScreen;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;

  const ScaffoldApp({
    super.key,
    this.appBar,
    required this.body,
    this.isFullScreen = false,
    this.backgroundColor,
    this.bottomNavigationBar,
  });

  void _sytemUIOverlay() {
    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _sytemUIOverlay();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
