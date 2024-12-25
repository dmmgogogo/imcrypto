class Token {
  final String symbol;
  final String name;
  final String balance;
  final double price;

  Token({
    required this.symbol,
    required this.name,
    required this.balance,
    required this.price,
  });

  double get balanceInUsd => double.parse(balance) * price;
} 