import 'package:flutter/material.dart';
import 'package:imcrypto/features/home/home_screen.dart';
import 'package:imcrypto/shared/themes/app_theme.dart';

class ImCryptoApp extends StatelessWidget {
  const ImCryptoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'imCrypto',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
} 