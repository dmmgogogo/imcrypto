import 'package:flutter/material.dart';

class BrowserScreen extends StatelessWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '浏览功能开发中...',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
} 