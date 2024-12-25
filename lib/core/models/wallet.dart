class CryptoWallet {
  final String address;
  final String publicKey;
  final String? name;
  
  const CryptoWallet({
    required this.address,
    required this.publicKey,
    this.name,
  });
  
  factory CryptoWallet.fromJson(Map<String, dynamic> json) {
    return CryptoWallet(
      address: json['address'] as String,
      publicKey: json['publicKey'] as String,
      name: json['name'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'publicKey': publicKey,
      'name': name,
    };
  }
} 