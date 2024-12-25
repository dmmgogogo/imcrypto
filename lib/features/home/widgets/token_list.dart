import 'package:flutter/material.dart';
import '../../../core/models/token.dart';

class TokenList extends StatelessWidget {
  final List<Token> tokens;
  
  const TokenList({Key? key, required this.tokens}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tokens.length,
      itemBuilder: (context, index) {
        final token = tokens[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(token.symbol[0]),
          ),
          title: Text(token.name),
          subtitle: Text(token.symbol),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${token.balance} ${token.symbol}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${token.balanceInUsd.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 