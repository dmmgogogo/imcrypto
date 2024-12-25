import 'package:flutter/foundation.dart';
import '../models/wallet.dart';
import '../models/token.dart';

class TokenProvider with ChangeNotifier {
  String _currentChain = 'TRON'; // 默认显示TRON链
  bool _isLoading = false;
  String? _error;
  List<Token> _tokens = [];
  
  String get currentChain => _currentChain;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Token> get tokens => _tokens;
  
  void switchChain(String chain) {
    _currentChain = chain;
    notifyListeners();
  }
  
  String? getAddressForChain(CryptoWallet? wallet) {
    if (wallet == null) return null;
    return wallet.accounts[_currentChain];
  }
  
  String formatAddress(String? address) {
    if (address == null) return '';
    if (address.length < 10) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }

  Future<void> loadTokens(String address) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: 实现实际的代币加载逻辑
      await Future.delayed(const Duration(seconds: 1)); // 模拟网络请求
      _tokens = [
        Token(
          symbol: currentChain == 'TRON' ? 'TRX' : 'ETH',
          name: currentChain == 'TRON' ? 'TRON' : 'Ethereum',
          balance: '0.0',
          price: currentChain == 'TRON' ? 0.08 : 2000.0,
        ),
      ];
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 