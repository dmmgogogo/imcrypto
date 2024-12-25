class Token {
  final String symbol;
  final String name;
  final String contractAddress;
  final int decimals;
  final double balance;
  final double price;
  final String imageUrl;
  
  const Token({
    required this.symbol,
    required this.name,
    required this.contractAddress,
    required this.decimals,
    required this.balance,
    required this.price,
    required this.imageUrl,
  });
  
  double get balanceInUsd => balance * price;
} 