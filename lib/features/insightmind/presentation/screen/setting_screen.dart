import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';

class SettingScreen extends StatelessWidget{
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldApp(
      body: Center(
        child: Text('Setting Screen'),
      ),
    );
  }
}