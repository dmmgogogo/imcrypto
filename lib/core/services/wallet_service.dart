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
  
  Future<CryptoWallet> createWallet() async {
    // 生成助记词
    final mnemonic = bip39.generateMnemonic();
    
    // 从助记词生成种子
    final seed = bip39.mnemonicToSeed(mnemonic);
    
    // 生成私钥
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    
    // 创建以太坊钱包
    final credentials = EthPrivateKey.fromHex(privateKey);
    final address = await credentials.extractAddress();
    
    // 安全存储助记词
    await _secureStorage.write(key: _mnemonicKey, value: mnemonic);
    
    return CryptoWallet(
      address: address.hex,
      publicKey: credentials.publicKey.toString(),
      name: 'Wallet 1',
    );
  }
  
  Future<String?> getMnemonic() async {
    return await _secureStorage.read(key: _mnemonicKey);
  }
} 