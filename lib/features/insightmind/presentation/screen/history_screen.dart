import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';

class HistoryScreen extends StatelessWidget{
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldApp(
      body: Center(
        child: Text('History Screen'),
      ),
    );
  }
}