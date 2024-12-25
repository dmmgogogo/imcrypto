import 'package:flutter/foundation.dart';
import '../models/wallet.dart';
import '../services/wallet_service.dart';

class WalletProvider with ChangeNotifier {
  final WalletService _walletService;
  CryptoWallet? _currentWallet;
  bool _isLoading = false;

  WalletProvider(): _walletService = WalletService();

  CryptoWallet? get currentWallet => _currentWallet;
  bool get isLoading => _isLoading;

  Future<void> createWallet() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _currentWallet = await _walletService.createWallet();
      notifyListeners();
    } catch (e) {
      debugPrint('Error creating wallet: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 