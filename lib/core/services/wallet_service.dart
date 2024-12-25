import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/web3dart.dart';
import 'package:hex/hex.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/wallet.dart';

class WalletService {
  final FlutterSecureStorage _secureStorage;
  static const String _mnemonicKey = 'mnemonic';
  
  WalletService(): _secureStorage = const FlutterSecureStorage();
  
  Future<(CryptoWallet, String)> createWallet({
    required String name,
    required String password,
    String? passwordHint,
  }) async {
    // 生成助记词
    final mnemonic = bip39.generateMnemonic();
    
    // 从助记词生成种子
    final seed = bip39.mnemonicToSeed(mnemonic);
    
    // 生成ETH地址
    final ethWallet = await _createEthereumWallet(seed);
    
    // 生成TRON地址
    final tronWallet = await _createTronWallet(seed);
    
    // 安全存储助记词
    await _secureStorage.write(
      key: _mnemonicKey,
      value: mnemonic,
    );
    
    // 安全存储密码提示（如果有）
    if (passwordHint != null) {
      await _secureStorage.write(
        key: 'password_hint',
        value: passwordHint,
      );
    }
    
    // 返回钱包信息和助记词
    return (
      CryptoWallet(
        name: name,
        address: ethWallet.$1,
        publicKey: ethWallet.$2,
        accounts: {
          'ETH': ethWallet.$1,
          'TRON': tronWallet.$1,
        },
      ),
      mnemonic,
    );
  }
  
  Future<(String, String)> _createEthereumWallet(List<int> seed) async {
    // ETH的BIP44路径: m/44'/60'/0'/0/0
    final masterKey = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(masterKey.key);
    
    final credentials = EthPrivateKey.fromHex(privateKey);
    final address = await credentials.extractAddress();
    final publicKey = credentials.publicKey.toString();
    
    return (address.hex, publicKey);
  }
  
  Future<(String, String)> _createTronWallet(List<int> seed) async {
    // TRON的BIP44路径: m/44'/195'/0'/0/0
    final masterKey = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(masterKey.key);
    
    // TODO: 使用TRON SDK生成地址
    // 这里暂时返回一个占位地址
    return ('T' + '0' * 33, 'tron_public_key');
  }
  
  Future<String?> getMnemonic() async {
    return await _secureStorage.read(key: _mnemonicKey);
  }
} 