import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/wallet_service.dart';
import 'core/providers/wallet_provider.dart';
import 'features/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WalletProvider(WalletService()),
        ),
      ],
      child: const App(),
    ),
  );
} 