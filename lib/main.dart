import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:imcrypto/core/providers/wallet_provider.dart';
import 'package:imcrypto/core/providers/token_provider.dart';
import 'package:imcrypto/features/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => TokenProvider()),
      ],
      child: const ImCryptoApp(),
    ),
  );
} 