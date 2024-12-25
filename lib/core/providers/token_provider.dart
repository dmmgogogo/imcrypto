import 'package:flutter/foundation.dart';
import '../models/token.dart';
import '../services/token_service.dart';

class TokenProvider with ChangeNotifier {
  final TokenService _tokenService;
  List<Token> _tokens = [];
  bool _isLoading = false;
  String? _error;

  TokenProvider(): _tokenService = TokenService();

  List<Token> get tokens => _tokens;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTokens(String walletAddress) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _tokens = await _tokenService.getTokens(walletAddress);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 