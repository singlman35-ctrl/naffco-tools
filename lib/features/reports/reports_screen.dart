import 'package:flutter/material.dart';
import '../../app/main_layout.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Center(
        child: Text(
          'Reports Screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
