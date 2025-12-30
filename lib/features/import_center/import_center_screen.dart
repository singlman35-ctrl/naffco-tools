import 'package:flutter/material.dart';
import '../../app/main_layout.dart';

class ImportCenterScreen extends StatelessWidget {
  const ImportCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Center(
        child: Text(
          'Import Center Screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
