import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import '../models/token.dart';

class TokenService {
  static const String _baseUrl = 'https://api.etherscan.io/api';
  final String _apiKey;

  TokenService() : _apiKey = dotenv.env['ETHERSCAN_API_KEY'] ?? '';

  Future<List<Token>> getTokens(String walletAddress) async {
    try {
      if (_apiKey.isEmpty) {
        throw Exception('API key not found');
      }

      // 获取 ERC20 代币列表
      final response = await http.get(Uri.parse(
        '$_baseUrl?module=account&action=tokentx&address=$walletAddress&sort=desc&apikey=$_apiKey'
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == '1') {
          // 处理返回的代币数据
          final List<dynamic> transactions = data['result'];
          final Map<String, Token> tokenMap = {};

          for (var tx in transactions) {
            final contractAddress = tx['contractAddress'];
            if (!tokenMap.containsKey(contractAddress)) {
              tokenMap[contractAddress] = Token(
                symbol: tx['tokenSymbol'],
                name: tx['tokenName'],
                contractAddress: contractAddress,
                decimals: int.parse(tx['tokenDecimal']),
                balance: 0, // 需要单独查询余额
                price: 0, // 需要单独查询价格
                imageUrl: 'https://etherscan.io/token/images/${contractAddress}.png',
              );
            }
          }

          // 获取代币余额和价格
          final tokens = tokenMap.values.toList();
          await _updateTokenBalances(tokens, walletAddress);
          await _updateTokenPrices(tokens);

          return tokens;
        }
      }
      throw Exception('Failed to load tokens');
    } catch (e) {
      throw Exception('Error loading tokens: $e');
    }
  }

  Future<void> _updateTokenBalances(List<Token> tokens, String walletAddress) async {
    // TODO: 实现代币余额查询
  }

  Future<void> _updateTokenPrices(List<Token> tokens) async {
    // TODO: 实现代币价格查询
  }
} 