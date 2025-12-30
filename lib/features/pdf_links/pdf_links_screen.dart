import 'package:flutter/material.dart';
import '../../app/main_layout.dart';

class PdfLinksScreen extends StatelessWidget {
  const PdfLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Center(
        child: Text(
          'PDF Links Screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
