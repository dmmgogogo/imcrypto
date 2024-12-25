import 'package:flutter/material.dart';
import '../backup/backup_mnemonic_screen.dart';

class SelectNetworksScreen extends StatefulWidget {
  const SelectNetworksScreen({Key? key}) : super(key: key);

  @override
  State<SelectNetworksScreen> createState() => _SelectNetworksScreenState();
}

class _SelectNetworksScreenState extends State<SelectNetworksScreen> {
  final Set<String> _selectedNetworks = {'Ethereum', 'Bitcoin', 'Dogecoin'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '添加账户',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Layer 1', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  _buildNetworkGrid([
                    _NetworkItem(
                      name: 'Bitcoin',
                      icon: 'assets/networks/bitcoin.png',
                      isSelected: true,
                    ),
                    _NetworkItem(
                      name: 'Ethereum',
                      icon: 'assets/networks/ethereum.png',
                      isSelected: true,
                    ),
                    _NetworkItem(
                      name: 'Dogecoin',
                      icon: 'assets/networks/dogecoin.png',
                      isSelected: true,
                    ),
                  ]),
                  const SizedBox(height: 24),
                  const Text('Layer 2', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  _buildNetworkGrid([
                    _NetworkItem(
                      name: 'Base',
                      icon: 'assets/networks/base.png',
                    ),
                  ]),
                  const SizedBox(height: 24),
                  const Text('EVM 兼容链', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  _buildNetworkGrid([
                    _NetworkItem(
                      name: 'Polygon',
                      icon: 'assets/networks/pol.png',
                    ),
                  ]),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  '添加 ${_selectedNetworks.length} 账户到 "abc"',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BackupMnemonicScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0052FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('确认'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkGrid(List<_NetworkItem> items) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: items.map((item) => _buildNetworkCard(item)).toList(),
    );
  }

  Widget _buildNetworkCard(_NetworkItem item) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[200]!,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(item.icon, width: 40, height: 40),
                const SizedBox(height: 8),
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Icon(
              item.isSelected ? Icons.check_circle : Icons.add_circle_outline,
              color: item.isSelected ? const Color(0xFF0052FF) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _NetworkItem {
  final String name;
  final String icon;
  final bool isSelected;

  _NetworkItem({
    required this.name,
    required this.icon,
    this.isSelected = false,
  });
} 