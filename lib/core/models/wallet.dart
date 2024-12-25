class CryptoWallet {
  final String address;  // 主地址（ETH）
  final String name;
  final String? publicKey;
  final Map<String, String> accounts;  // 各链的地址
  
  CryptoWallet({
    required this.address,
    required this.name,
    this.publicKey,
    this.accounts = const {},
  });
  
  factory CryptoWallet.fromJson(Map<String, dynamic> json) {
    return CryptoWallet(
      address: json['address'] as String,
      name: json['name'] as String,
      publicKey: json['publicKey'] as String?,
      accounts: Map<String, String>.from(json['accounts'] as Map),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'name': name,
      if (publicKey != null) 'publicKey': publicKey,
      'accounts': accounts,
    };
  }
} 