import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/wallet_provider.dart';
import '../../core/providers/token_provider.dart';
import 'widgets/wallet_card.dart';
import 'widgets/action_buttons.dart';
import 'widgets/asset_tabs.dart';
import 'widgets/token_list.dart';
import '../onboarding/onboarding_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<WalletProvider>(
          builder: (context, walletProvider, child) {
            if (walletProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (walletProvider.currentWallet == null) {
              return _buildCreateWalletPrompt(context);
            }

            return RefreshIndicator(
              onRefresh: () async {
                final wallet = walletProvider.currentWallet!;
                await context.read<TokenProvider>().loadTokens(
                  context.read<TokenProvider>().getAddressForChain(wallet) ?? '',
                );
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    WalletCard(
                      wallet: walletProvider.currentWallet!,
                      balance: 0.0,  // 这里可以从 TokenProvider 中获取余额
                    ),
                    const SizedBox(height: 24),
                    const ActionButtons(),
                    const SizedBox(height: 24),
                    AssetTabs(
                      selectedIndex: _selectedTabIndex,
                      onTabSelected: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Consumer<TokenProvider>(
                      builder: (context, tokenProvider, child) {
                        if (tokenProvider.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (tokenProvider.error != null) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Error: ${tokenProvider.error}'),
                                ElevatedButton(
                                  onPressed: () {
                                    tokenProvider.loadTokens(
                                      walletProvider.currentWallet!.address,
                                    );
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        }

                        return TokenList(tokens: tokenProvider.tokens);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCreateWalletPrompt(BuildContext context) {
    return const OnboardingScreen();
  }
} 