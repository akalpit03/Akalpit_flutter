import 'package:flutter/material.dart';

class SimplePage1 extends StatelessWidget {
  const SimplePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Hello Flutter 1',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'This is a very simple page',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
