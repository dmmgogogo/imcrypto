import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/models/wallet.dart';
import '../../../core/providers/token_provider.dart';

class WalletCard extends StatelessWidget {
  final CryptoWallet wallet;
  final double balance;

  const WalletCard({
    Key? key,
    required this.wallet,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TokenProvider>(
      builder: (context, tokenProvider, child) {
        final address = tokenProvider.getAddressForChain(wallet);
        
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0052FF), Color(0xFF2E7DFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    wallet.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (chain) {
                      tokenProvider.switchChain(chain);
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'TRON',
                        child: Text('TRON'),
                      ),
                      const PopupMenuItem(
                        value: 'ETH',
                        child: Text('Ethereum'),
                      ),
                    ],
                    child: Row(
                      children: [
                        Text(
                          tokenProvider.currentChain == 'TRON' ? 'TRON' : 'Ethereum',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                '\$ ${balance.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    tokenProvider.formatAddress(address),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white70, size: 16),
                    onPressed: () {
                      // TODO: 实现复制地址功能
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
} 