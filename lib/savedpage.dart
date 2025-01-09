import 'package:flutter/material.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          'No Articles are saved yet, Start Now.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
