import 'package:flutter/foundation.dart';
import '../services/wallet_service.dart';
import '../models/wallet.dart';

class WalletProvider with ChangeNotifier {
  final WalletService _walletService;
  bool isLoading = false;
  String? error;
  CryptoWallet? currentWallet;
  String? _mnemonic;

  WalletProvider(this._walletService);

  Future<void> createWallet({
    required String name,
    required String password,
    String? passwordHint,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await _walletService.createWallet(
        name: name,
        password: password,
        passwordHint: passwordHint,
      );
      
      currentWallet = result.$1;
      _mnemonic = result.$2;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<String?> getMnemonic() async {
    return _mnemonic ?? await _walletService.getMnemonic();
  }
} 