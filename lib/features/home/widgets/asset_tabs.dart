import 'package:flutter/material.dart';

class AssetTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const AssetTabs({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildTab('Tokens', 0),
          const SizedBox(width: 24),
          _buildTab('NFT', 1),
          const SizedBox(width: 24),
          _buildTab('DeFi', 2),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blue),
            onPressed: () {
              // TODO: 实现添加资产
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onTabSelected(index),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: 40,
            color: isSelected ? Colors.blue : Colors.transparent,
          ),
        ],
      ),
    );
  }
} 